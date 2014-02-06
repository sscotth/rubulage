require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'
require 'rubulage/database'

namespace :test do

  desc 'Run RSpec Tests'
  RSpec::Core::RakeTask.new(:spec) do |t|
    ENV['RUBY_ENV']='test'
  end

  desc 'Run only RSpec tests tagged as work-in-progress'
  RSpec::Core::RakeTask.new('spec:wip') do |t|
    ENV['RUBY_ENV']='test'
    t.rspec_opts = '-tags wip ~pending'
  end

  desc 'Run Cucumber Tests'
  Cucumber::Rake::Task.new(:features) do |t|
    ENV['RUBY_ENV']='test'
    t.cucumber_opts = 'features -f pretty -xs --tags ~@pending'
    t.fork = false
  end

  desc 'Run only cucumber tests tagged as work-in-progress (@wip)'
  Cucumber::Rake::Task.new('features:wip') do |t|
    ENV['RUBY_ENV']='test'
    tag_opts = ' --tags ~@pending'
    tag_opts = ' --tags @wip'
    t.cucumber_opts = "features -r features -f pretty -xs#{tag_opts}"
    t.fork = false
  end
end

namespace :db do
  desc 'Prepare production database'
  task :prepare do
    ENV['RUBY_ENV']='production'
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
  end
  namespace :test do
    desc 'Prepare test database'
    task :prepare do
      ENV['RUBY_ENV']='test'
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
    end
  end
end

task :default => ['test:spec']
