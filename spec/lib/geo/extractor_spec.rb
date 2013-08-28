require 'spec_helper'
require 'geo/extractor'

module Geo
  describe Extractor do

    let (:result) {{
      '_id' => 'LS116AE',
      '_type' => 'postcode',
      '_source' => {
        'name' => ['LS11 5HH', 'LS115HH'],
        'latitude' => 54.321,
        'longitude' => -1.2345
      }
    }}

    let (:extractor) { Extractor.new(result) }

    it 'extracts the relevant fields from the result' do
      expect(extractor.extracted).to eq ({
        id:"LS116AE",
        name:"LS11 5HH",
        latitude:54.321,
        longitude:-1.2345,
        type:"postcode"
      })
    end
  end
end
