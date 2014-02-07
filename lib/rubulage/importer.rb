require 'csv'
require 'rubulage/transactions'
module Rubulage

  class Importer

    def self.csv(file)
      CSV.foreach(file, skip_blanks: true, skip_lines: /^(((?!"gal"|Additive).))*$/, headers: true) do |row|
        Transactions.create!({
          date: Time.strptime("#{row['Date']} #{row['Time']}", "%m/%d/%Y %I:%M %p").to_i,
          odometer: row['Odometer Reading'].gsub(',','').to_i,
          gallons: row['Volume'].to_f,
          price: row['Price per Unit'].gsub('$','').to_f,
          partial: row['Partial Fill-Up?'] == 'Yes',
          missed: row['Previously Missed Fill-Ups?'] == 'Yes'
        })
      end
      puts "#{Transactions.count} tranasctions now in database"
    end
  end

end
