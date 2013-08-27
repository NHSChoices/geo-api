require 'spec_helper'

require 'goliath'
require 'geo/search'

class GeoApi < Goliath::API
  use Goliath::Rack::Heartbeat
  use Goliath::Rack::Render, 'json'

  def response(env)
    Geo::Search.new(env).response
  end

end

describe GeoApi do

  it 'echoes stuff' do
    with_api GeoApi do
      get_request(path: '/geo/stuff') do |request|
        expect(request.response).to eq 'stuff'
      end
    end
  end

  it 'returns json' do
    with_api GeoApi do
      get_request(path: '/geo/stuff') do |request|
        content_type = request.response_header['CONTENT_TYPE']
        expect(content_type).to eq 'application/json'
      end
    end
  end

end
