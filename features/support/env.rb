require 'aruba/cucumber'

require 'logger'
require 'sqlite3'

LOGGER = Logger.new('tmp/cucumber.log')

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

Before do
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
  @dirs = '.'
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end

db = Rubulage::Database.connection
db.execute('DROP TABLE IF EXISTS transactions')
db.execute('CREATE TABLE transactions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date DATETIME NOT NULL,
  odometer INTEGER NOT NULL,
  price INTEGER NOT NULL,
  gallons INTEGER NOT NULL,
  total INTEGER NOT NULL,
  missed TINYINT(1) NOT NULL DEFAULT 0,
  partial TINYINT(1) NOT NULL DEFAULT 0
)')
