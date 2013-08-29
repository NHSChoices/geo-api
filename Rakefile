#!/usr/bin/env rake
require 'cucumber'
require 'cucumber/rake/task'
require 'coveralls/rake/task'

Coveralls::RakeTask.new
Cucumber::Rake::Task.new

namespace :test do

  desc 'Run all tests and code quality tools'
  task :all do
    Rake::Task['spec'].invoke
    Rake::Task['cucumber'].invoke
    Rake::Task['coveralls:push'].invoke
    fail "Rubocop offences" unless system 'rubocop'
  end

end

task default: "test:all"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new
