require 'spec_helper'
require 'geo/search'

describe Geo::Search do
  describe '#query' do

    let (:env)    { { 'REQUEST_URI' => '/geo/stuff' } }
    let (:search) { Geo::Search.new(env) }

    it 'returns the request uri stripped of its prefix' do
      expect(search.query).to eq 'stuff'
    end

    it 'returns json content-type' do
      _, headers, _ = search.response
      expect(headers.fetch('CONTENT-TYPE')).to eq 'application/json'
    end

    it 'returns 200 as status' do
      status, _, _ = search.response
      expect(status).to eq 200
    end
  end
end
