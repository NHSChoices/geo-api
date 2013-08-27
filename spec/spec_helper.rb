require 'bundler'

Bundler.setup
Bundler.require

require 'goliath/test_helper'

require 'coveralls'
Coveralls.wear!

Goliath.env = :test

RSpec.configure do |c|
  c.include Goliath::TestHelper, example_group: { file_path: /spec\/integration/ }
  c.order = :rand
  c.mock_with :mocha
end
