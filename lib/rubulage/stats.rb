require 'rubulage/database'

module Rubulage
  class Stats
    SECONDS_PER_YEAR = 86400.0

    def self.output_hash
      {
        "FUEL SPENT" => {
          "Average Fuel per Fill-up" => self.avg_volume.round(2),
          "Maximum Fuel per Fill-up" => self.max_volume.round(2),
          "Total Fuel"               => self.total_volume.round(2),
          "Average Fuel per Day"     => self.avg_fuel_per_day.round(2)
        },

        "MILES PER GALLON" => {
          "Minimum MPG" => self.min_mpg.round(2),
          "Average MPG" => self.avg_mpg.round(2),
          "Maximum MPG" => self.max_mpg.round(2)
        },

        "PRICE" => {
          "Minimum Price Paid"    => self.min_price.round(3),
          "Average Price Paid"    => self.avg_price.round(3),
          "Maximum Price Paid"    => self.max_price.round(3),
          "Total Paid"            => self.total_money.round(2),
          "Average Paid per Mile" => self.avg_money_per_mile.round(2),
          "Average Paid per Day"  => self.avg_money_per_day.round(2)
        },

        "DISTANCE" => {
          "Average Miles Travelled between Fill-ups"   => self.avg_distance.round(2),
          "Maximum Miles Travelled between Fill-ups"   => self.max_distance.round(2),
          "Total Miles Travelled"                      => self.total_money.round(2),
          "Average Miles Travelled per Dollar of Fuel" => self.avg_miles_per_money.round(2),
          "Average Miles Travelled per Day"            => self.avg_miles_per_day.round(2),
          "Average Days between Fill-ups"              => self.avg_days_per_fill.round(2)
        }
      }
    end

    def self.to_table(hash)
      table = Terminal::Table.new do |t|
        hash.each do |category, stat_group|
          t.add_separator unless category == hash.keys.first
          t.add_row [{value: category, colspan: 2, alignment: :center}]
          t.add_separator
          stat_group.each do |k,v|
            t.add_row [k,{value: v, alignment: :center}]
          end
        end
      end
      table
    end

    def self.min_mpg
      db = Database.connection
      sql = "SELECT MIN(mpg) FROM (#{Transactions.sql_with_mpg})"
      db.get_first_value(sql).to_f
    end

    def self.max_mpg
      db = Database.connection
      sql = "SELECT MAX(mpg) FROM (#{Transactions.sql_with_mpg})"
      db.get_first_value(sql).to_f
    end

    def self.avg_mpg
      db = Database.connection
      sql = "SELECT ( MAX(odometer) - MIN(odometer) ) / SUM(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.min_price
      db = Database.connection
      sql = "SELECT MIN(price) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.max_price
      db = Database.connection
      sql = "SELECT MAX(price) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_price
      db = Database.connection
      sql = "SELECT SUM(price * gallons) / SUM(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.max_volume
      db = Database.connection
      sql = "SELECT MAX(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_volume
      db = Database.connection
      sql = "SELECT SUM(gallons) / COUNT(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.max_distance
      db = Database.connection
      sql = "SELECT MAX(miles) FROM (#{Transactions.sql_with_mpg(nil,true)})"
      db.get_first_value(sql).to_f
    end

    def self.avg_distance
      db = Database.connection
      sql = "SELECT AVG(miles) FROM (#{Transactions.sql_with_mpg(nil,true)})"
      db.get_first_value(sql).to_f
    end

    def self.total_distance
      db = Database.connection
      sql = "SELECT #{sql_total_miles} FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_money_per_mile
      db = Database.connection
      sql = "SELECT SUM(total) / #{sql_total_miles} FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_miles_per_money
      db = Database.connection
      sql = "SELECT #{sql_total_miles} / SUM(total) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_money_per_day
      db = Database.connection
      sql = "SELECT SUM(total) / #{sql_per_day} FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_miles_per_day
      db = Database.connection
      sql = "SELECT #{sql_total_miles} / #{sql_per_day} FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_fuel_per_day
      db = Database.connection
      sql = "SELECT SUM(gallons) / #{sql_per_day} FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.avg_days_per_fill
      db = Database.connection
      sql = "SELECT #{sql_per_day} / COUNT(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.total_money
      db = Database.connection
      sql = "SELECT SUM(total) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.total_volume
      db = Database.connection
      sql = "SELECT SUM(gallons) FROM #{Transactions::TABLE_NAME}"
      db.get_first_value(sql).to_f
    end

    def self.sql_total_miles
      '( MAX(odometer) - MIN(odometer) )'
    end

    def self.sql_per_day
      "( ( MAX(date) - MIN(date) * 1.0 ) / #{SECONDS_PER_YEAR} )"
    end

  end

end
