require 'spec_helper'

describe Geo::Request do

  let (:env)    { { 'REQUEST_URI' => '/geo/stuff' } }
  let (:search) { Geo::Request.new(env) }

  describe "#response" do

    it 'has a status code of 200' do
      expect(search.status).to eq 200
    end

    it 'has a content-type of application/json' do
      expect(search.headers.fetch('Content-Type')).to eq 'application/json'
    end

    it 'returns an array of matches' do
      stub_request(:get, /localhost:9200\/geo_test\/_search/).to_return(Fixtures.matches)
      EM.synchrony do
        _, _, body = search.response
        expect(body.fetch(:matches).first).to be_a Hash
        EM.stop
      end
    end

    it 'returns an array of alternatives if there are no matches' do
      search.stubs(:matches).returns([])
      stub_request(:get, /localhost:9200\/geo_test\/_search/).to_return(Fixtures.alternatives)
      EM.synchrony do
        _, _, body = search.response
        expect(body.fetch(:alternatives).first).to be_a Hash
        EM.stop
      end
    end

    it 'returns an empty array of alternatives if there are matches' do
      stub_request(:get, /localhost:9200\/geo_test\/_search/).to_return(Fixtures.matches)
      EM.synchrony do
        _, _, body = search.response
        expect(body.fetch(:alternatives)).to be_empty
        EM.stop
      end
    end

  end
end
