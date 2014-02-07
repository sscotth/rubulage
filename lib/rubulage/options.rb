require 'optparse'
require 'optparse/time'

module Rubulage

  class Options

    def self.parse(args)

      options = {}

      OptionParser.new do |opts|
        opts.banner = 'Usage: rubulage [command] [options]'
        opts.separator ""
        opts.separator "Commands: add, list, stats, import"
        opts.separator ""

        opts.on('-d', '--date DATE', Time, 'Transaction Date: yyyy/mm/sss [hh:mm:ss]') do |date|
          options[:date] = date.to_i
        end

        opts.on('-o', '--odo ODOMETER', Float, 'Odometer Reading: 1234567.8') do |odo|
          options[:odometer] = odo.round(1)
        end

        opts.on('-i', '--id ID', Integer, 'Transaction ID') do |id|
          options[:id] = id
        end

        opts.on('-g', '--gal GALLONS', Float, 'Gallons Purchased: 12.345') do |gal|
          options[:gallons] = gal.round(3)
        end

        opts.on('-p', '--price PRICE', Float, 'Price Per Gallon: 3.459') do |ppg|
          options[:price] = ppg_with_9(ppg)
        end

        opts.on('-m', '--missed', 'Missed Fill-up(s)') do |missed|
          options[:missed] = missed
        end

        opts.on('-n', '--not-full', '--partial', 'Partial Fill-up') do |partial|
          options[:partial] = partial
        end

        opts.on_tail('--version', 'Show version') do
          puts VERSION
          exit
        end

      end.parse(args)

      options[:command] = ARGV[0]
      options[:argv1] = ARGV[1]
      options

    end

    private

    def self.ppg_with_9(number)
      (round_down(number, 2) + 0.009).round(3)
    end

    def self.round_down(float, precision=0)
      precision < 1 ? float.to_i : (float - 0.5 / 10 ** precision).round(precision)
    end

  end

end
