require 'spec_helper'

module Rubulage
  describe Options do
    describe 'self.parse' do

      it '-d returns a datetime' do
        date = Time.at(1388534400)
        options = Options.parse(['-d','2014/1/1 0:0:0 GMT'])
        options[:date].should eq(date)
      end

      it '--date returns a datetime' do
        options = Options.parse(['--date','2014-1-1'])
        options[:date].should eq(Time.parse('2014-1-1 00:00:00'))
      end

      it '-o returns a float rounded to 1 decimal' do
        options = Options.parse(['-o','12345.678'])
        options[:odometer].should equal(12345.7)
      end

      it '--odo returns a float rounded to 1 decimal' do
        options = Options.parse(['--odo','12345'])
        options[:odometer].should equal(12345.0)
      end

      it '-o rejects non-numerics' do
        expect { Options.parse(['-o','a']) }.to\
        raise_error(OptionParser::InvalidArgument)
      end

      it '-i returns an integer' do
        options = Options.parse(['-i','1'])
        options[:id].should equal(1)
      end

      it '--id returns an integer' do
        options = Options.parse(['--id','1'])
        options[:id].should equal(1)
      end

      it '-i rejects non-integers' do
        expect { Options.parse(['-i','1.2']) }.to\
        raise_error(OptionParser::InvalidArgument)
      end

      it '-g returns a float rounded to 3 decimals' do
        options = Options.parse(['-g','1.2345'])
        options[:gallons].should equal(1.235)
      end

      it '--gal returns a float rounded to 3 decimals' do
        options = Options.parse(['--gal','1'])
        options[:gallons].should equal(1.0)
      end

      it '-g rejects non-numerics' do
        expect { Options.parse(['-g','a']) }.to\
        raise_error(OptionParser::InvalidArgument)
      end

      it '-p returns a number truncated to 2 decimals with a trailing 0.009' do
        options = Options.parse(['-p','2.34'])
        options[:price].should equal(2.349)
      end

      it '--price returns a number rounded to 2 decimals with a trailing 0.009' do
        options = Options.parse(['--price','2.3499'])
        options[:price].should equal(2.349)
      end

      it '-p rejects non-numerics' do
        expect { Options.parse(['-p','a']) }.to\
        raise_error(OptionParser::InvalidArgument)
      end

      it '-m returns true' do
        options = Options.parse(['-m'])
        options[:missed].should be_true
      end

      it '--missed returns true' do
        options = Options.parse(['--missed'])
        options[:missed].should be_true
      end

      it ':missed is false if not declared' do
        options = Options.parse([])
        options[:missed].should be_false
      end

      it '-n returns true' do
        options = Options.parse(['-n'])
        options[:partial].should be_true
      end

      it '--not-full returns true' do
        options = Options.parse(['--not-full'])
        options[:partial].should be_true
      end

      it '--partial returns true' do
        options = Options.parse(['--partial'])
        options[:partial].should be_true
      end

      it ':partial is false if not declared' do
        options = Options.parse([])
        options[:partial].should be_false
      end
    end

    describe 'self.ppg_with_9' do
      it 'should truncate to two digits with a trailing 9' do
        Options.ppg_with_9(3.4599).should equal(3.459)
      end

      it 'should add decimals where needed' do
        Options.ppg_with_9(1).should equal(1.009)
      end
    end

    describe 'self.round_down' do
      it 'rounds numbers down to nearest integer' do
        Options.round_down(0.1).should equal(0)
        Options.round_down(1.5).should equal(1)
        Options.round_down(2.9,-1).should equal(2)
        Options.round_down(3.1,0).should equal(3)
      end

      it 'rounds down to hundreths' do
        Options.round_down(1.1,2).should equal(1.1)
        Options.round_down(2.999,2).should equal(2.99)
        Options.round_down(0).should equal(0)
      end
    end
  end
end
