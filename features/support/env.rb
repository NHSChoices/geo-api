require 'bundler'

Bundler.setup
Bundler.require

require 'cucumber'
require 'yajl'
require 'goliath/test_helper'

Goliath.env = :test

require 'simplecov'
require 'coveralls'
SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

SimpleCov.start do
  add_filter '/spec'
  add_filter '/features'
  coverage_dir 'reports/coverage'
end

require './geo_api'

require './features/support/fixtures'

World(Goliath::TestHelper)

Fixtures.setup!
at_exit { Fixtures.tear_down! }
