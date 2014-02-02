require 'optparse'
require 'optparse/time'

module Rubulage

  class Options

    def self.parse

      options = {}

      OptionParser.new do |opts|
        opts.banner = 'Usage: rubulage [command] [options]'

        opts.on('--date [DATE]', Time, 'Transaction Date: yyyy/mm/sss [hh:mm:ss]') do |date|
          options[:date] = date
        end

        opts.on('--odo [ODOMETER]', 'Odometer Reading: 1234567.8') do |odo|
          options[:odometer] = odo.to_f.round(1)
        end

        opts.on('--id [ID]', 'Transaction ID') do |id|
          options[:id] = id.to_i
        end

        opts.on('--gal [GAL]', 'Gallons Purchased: 12.345') do |gal|
          options[:gallons] = gal.to_f.round(3)
        end

        opts.on('--ppg [PRICE]', 'Price Per Gallon: 3.459') do |ppg|
          options[:price] = ppg_with_9(ppg)
        end

        opts.on('--missed', 'Missed Fill-up(s)') do |missed|
          options[:missed] = missed
        end

        opts.on('--partial', 'Partial Fill-up') do |partial|
          options[:partial] = partial
        end

        opts.on_tail("--version", "Show version") do
          puts VERSION
          exit
        end

      end.parse!

      options[:command] = ARGV[0]
      options

    end

    private

    def self.ppg_with_9(number)
      number = round_down(number, 2)
      (number + 0.009).round(3)
    end

    def self.round_down(number, precision=0)
      number = number.to_f
      precision < 1 ? number.to_i.to_f : (number - 0.5 / 10 ** precision).round(precision)
    end

  end

end
