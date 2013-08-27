#!/usr/bin/env rake

namespace :test do
  desc 'Run all tests and code quality tools'
  task :all do
    Rake::Task['spec'].invoke
    system 'rubocop'
  end
end

task default: "test:all"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new
