module Rubulage

  class Transactions

    TABLE_NAME = 'transactions'
    ATTRIBUTES = [:date, :odometer, :gallons, :price, :missed, :partial, :mpg]

    attr_accessor *ATTRIBUTES
    attr_reader :id
    attr

    def initialize(attributes = {})
      update_attributes(attributes)
    end

    def self.create!(attributes = {})
      tx = self.new(attributes)
      tx.save
      tx
    end

    def save
      db = Database.connection
      if(id)
        sql = "UPDATE #{TABLE_NAME} SET date = '#{self.date.to_i}', odometer = #{odometer}, gallons = #{gallons}, price = #{price}, total = #{total}, missed = #{missed}, partial = #{partial} WHERE id = #{id}"
      else
        sql = "INSERT INTO #{TABLE_NAME}(date, odometer, gallons, price, total, missed, partial) VALUES('#{self.date.to_i}', #{self.odometer}, #{gallons}, #{price}, #{total}, #{missed}, #{partial})"
      end
      db.execute(sql)
      @id = db.last_insert_row_id
    end

    def update(attributes = {})
      update_attributes(attributes)
      save
    end

    def self.find(id)
      db = Database.connection(true)
      result = db.execute(sql_with_mpg(id))[0]
      if result
        tx = self.new(date: result['date'], odometer: result['odometer'], gallons: result['gallons'], price: result['price'], total: result['total'], missed: result['missed'], partial: result['partial'], mpg: result['mpg'])
        tx.send("id=", result['id'])
        [tx.to_a]
      else
        []
      end
    end

    def to_hash
      missed = self.missed == 1
      partial = self.partial == 1
      {id: self.id, date: self.date, odometer: self.odometer, price: self.price, gallons: self.gallons, total: self.total, missed: missed, partial: partial, mpg: self.mpg}
    end

    def to_s
      self.to_hash
    end

    def to_a
      self.to_hash.values
    end

    def self.to_table(array)
      results = array.map do |row|
        row[1] = Time.at(row[1]).strftime("%m/%d/%Y")
        row[2] = '%.01f' % row[2]
        row[3] = '%.03f' % row[3]
        row[4] = '%.03f' % row[4]
        row[5] = '%.02f' % row[5]
        row[6] = row[6] == 1
        row[7] = row[7] == 1
        row[8] = row[8] ? '%.01f' % row[8] : '---'
      end
      table = Terminal::Table.new do |t|
        headers = ['id','date','odometer','price','gallons','total','missed','partial','mpg']
        t.headings = headers
        t.rows = array
        headers.count.times do |i|
          t.align_column(i, :right)
        end
      end
      table
    end

    def self.count
      db = Database.connection
      sql = "SELECT COUNT(*) FROM #{TABLE_NAME}"
      db.get_first_value(sql).to_i
    end

    def total
      (self.price.to_f * self.gallons.to_f).round(2)
    end

    def self.sql_with_mpg(id=nil,distance=false)
      where = "WHERE #{TABLE_NAME}.id = #{id}" if id
      "SELECT transactions.*,
        CASE
          WHEN t.missed = 1 THEN NULL
        ELSE
          t.miles / ( ifnull(t.partial, 0) + t.gallons * 1.0 )
        END mpg
      #{', CASE WHEN t.missed = 1 OR t.partial > 0 THEN NULL ELSE t.miles END miles' if distance}
      FROM transactions
      LEFT OUTER JOIN (
        SELECT fill.id id, gallons, partial, miles, missed
        FROM
          (
            SELECT t1.id, t2.gallons, t2.missed, t2.odometer - t1.odometer miles
            FROM
              (
                SELECT
                  (
                    SELECT count(*)
                    FROM transactions b
                    WHERE partial = 0
                    AND a.odometer >= b.odometer
                  ) AS order_id,
                  id, odometer
                FROM transactions a
                WHERE partial = 0
                ORDER BY order_id
              ) t1
            LEFT OUTER JOIN (
              SELECT
                (
                  SELECT count(*)
                  FROM transactions b
                  WHERE partial = 0
                    AND a.odometer >= b.odometer
                ) AS order_id,
                gallons, odometer, missed
              FROM transactions a
              WHERE partial = 0
              ORDER BY order_id
            ) t2 ON t1.order_id + 1 = t2.order_id
            ORDER BY t1.odometer
          ) fill
        LEFT OUTER JOIN (
          SELECT
            id, gallons partial
          FROM
            (
              SELECT
                (
                  SELECT count(*)
                  FROM transactions b
                  WHERE a.odometer >= b.odometer
                ) AS order_id,
                id
              FROM
                transactions a
              ORDER BY
                order_id
            ) t1
          INNER JOIN (
            SELECT
              (
                SELECT
                  count(*)
                FROM
                  transactions b
                WHERE
                  a.odometer >= b.odometer
              ) AS order_id,
              gallons
            FROM
              transactions a
            WHERE
              partial = 1
            ORDER BY
              order_id
          ) t2 ON t1.order_id + 1 = t2.order_id
        ) partial ON fill.id = partial.id
      ) t ON transactions.id = t.id
      #{where}
      ORDER BY odometer"
    end

    def self.all
      db = Database.connection
      result = db.execute(sql_with_mpg)
    end

    private

    def id=(id)
      @id = id
    end

    def update_attributes(attributes)
      attributes[:missed] = attributes[:missed] ? 1 : 0
      attributes[:partial] = attributes[:partial] ? 1 : 0
      ATTRIBUTES.each do |attr|
        self.send("#{attr}=", attributes[attr]) if attributes[attr]
      end
    end

  end

end
