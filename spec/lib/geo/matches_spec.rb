require 'spec_helper'

module Geo
  describe Matches do

    before do
      stub_request(:get, /localhost:9200\/geo_test\/_search/).to_return(Fixtures.matches)
    end

    let (:matches) { Matches.new('Lee') }

    it 'searches the geo index in elasticsearch' do
      expect(matches.url).to eq 'http://localhost:9200/geo_test/_search'
    end

    it 'queries elasticsearch for prefix matches' do
      expect(matches.query).to eq ({
        'query' => { 'text_phrase_prefix' => { 'name' => 'Lee' } }
      })
    end

    it 'parses, extracts and returns the results' do
      EM.synchrony do
        expect(matches.results).to eq [
         { id: "LS116AF", name: "LS11 6AF", latitude: 53.7789916992188, longitude: -1.55076897144318, type: "postcode"},
         { id: "LS116DL", name: "LS11 6DL", latitude: 53.7771949768066, longitude: -1.55078816413879, type: "postcode"}
       ]
       EM.stop
      end
    end
  end
end
