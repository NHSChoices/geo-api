require 'spec_helper'
require 'geo/search'

describe Geo::Search do
  describe '#query' do

    let (:env)    { { 'REQUEST_URI' => '/geo/stuff' } }
    let (:search) { Geo::Search.new(env) }

    it 'returns the request uri stripped of its prefix' do
      expect(search.query).to eq 'stuff'
    end
  end
end
