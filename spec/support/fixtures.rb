require 'faraday'

module Fixtures
  extend self

  def method_missing(name, *args, &block)
    File.read "spec/support/#{name}.json"
  end

  def setup!
    http = Faraday.new("http://localhost:9200")
    examples.each do |e|
      http.post('/geo_test/place?refresh=true', e).body
    end
  end

  def tear_down!
    Faraday.delete(domain).body
  end

  def domain
    "http://#{Geo::Configuration.elastic_search_domain}/place"
  end

  def examples
    [
      '{ "name": ["Leeds, West Yorkshire"], "latitude": 1, "longitude": 2 }',
      '{ "name": ["Leeds, Kent"], "latitude": 1, "longitude": 2 }'
    ]
  end
end
