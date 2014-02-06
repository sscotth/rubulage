require 'terminal-table'

module Rubulage

  class Commands

    def self.add(options)
      mandatory = [:date, :odometer, :gallons, :price]
      check = []
      missing = []
      mandatory.each { |opt| options[opt] ? check << options[opt] : missing << opt }
      if missing.empty?
        result = Transactions.create!({
            date: options[:date],
            odometer: options[:odometer],
            gallons: options[:gallons],
            price: options[:price],
            missed: options[:missed],
            partial: options[:partial]})
        puts "\nSaved!\n\n#{Transactions.to_table([result.to_a])}" if result.id
      else
        raise OptionParser::MissingArgument, missing
      end
    end

  end
end
