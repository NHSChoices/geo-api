require 'bundler'

Bundler.setup
Bundler.require

require 'goliath/test_helper'

require 'geo/configuration'
require 'geo/matches'
require 'geo/request'
require 'geo/extractor'

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec'
  coverage_dir 'reports/coverage'
end

Goliath.env = :test

require 'webmock/rspec'
require 'support/fixtures'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |c|
  c.include Goliath::TestHelper, example_group: { file_path: /spec\/integration/ }
  c.order = :rand
  c.mock_with :mocha
end
