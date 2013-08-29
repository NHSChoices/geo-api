require 'spec_helper'

describe GeoApi do

  it 'returns a list of match documents' do
    with_api GeoApi do
      get_request(path: '/geo/leed') do |request|
        response = Yajl::Parser.parse(request.response)
        match = response.fetch('matches').first
        expect(match).to have_key('id')
        expect(match).to have_key('name')
        expect(match).to have_key('type')
        expect(match).to have_key('latitude')
        expect(match).to have_key('longitude')
      end
    end
  end

  it 'returns a list of alternatives if there are no matches' do
    with_api GeoApi do
      get_request(path: '/geo/leads') do |request|
        response = Yajl::Parser.parse(request.response)
        expect(response.fetch('matches')).to be_empty
        expect(response.fetch('alternatives')).to have_at_least(1).item
      end
    end
  end

  it 'returns a content type of json' do
    with_api GeoApi do
      get_request(path: '/geo/leed') do |request|
        content_type = request.response_header['CONTENT_TYPE']
        expect(content_type).to eq 'application/json'
      end
    end
  end

end
