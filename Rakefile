require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

namespace :test do

  desc 'Run RSpec Tests'
  RSpec::Core::RakeTask.new(:spec)

  desc 'Run Cucumber Tests'
  Cucumber::Rake::Task.new(:features) do |t|
    t.cucumber_opts = "features -f pretty -xs"
    t.fork = false
  end

  desc 'Run only cucumber tests tagged as work-in-progress (@wip)'
  Cucumber::Rake::Task.new('features:wip') do |t|
    tag_opts = ' --tags ~@pending'
    tag_opts = ' --tags @wip'
    t.cucumber_opts = "features -f pretty -xs#{tag_opts}"
    t.fork = false
  end
end

task :default => ['test:spec','test:features']
