require 'faraday'

module Fixtures
  extend self

  def method_missing(name, *args, &block)
    File.read "spec/support/#{name}.json"
  end

end
