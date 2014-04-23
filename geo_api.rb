require 'goliath'
require './lib/geo'

class GeoApi < Goliath::API
  use Goliath::Rack::Heartbeat
  use Goliath::Rack::Render, 'json'

  def response(env)
    Geo::Request.new(env).response
  end
end
