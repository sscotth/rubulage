require 'sqlite3'
require 'logger'

module Rubulage
  class Database < SQLite3::Database

    LOGGER = Logger.new(Dir.pwd + 'database.log')

    def self.file
      ENV["RUBY_ENV"] == 'test' ? '/db/test.sl3' : '/db/production.sl3'
    end

    def self.connection(results_as_hash = false)
      db ||= Database.new(Dir.pwd + file)
      db.results_as_hash = results_as_hash
      db
    end

    def execute(statement)
      LOGGER.info("#{Database.file} Exec: " + statement)
      super(statement)
    end

  end
end
