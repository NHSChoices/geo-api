require 'spec_helper'

module Geo
  describe Matches do

    let (:matches) { Matches.new('Lee') }

    it 'queries elasticsearch for prefix matches' do
      expect(matches.query).to eq ({
        'query' => { 'text_phrase_prefix' => { 'name' => 'Lee' } }
      })
    end

  end
end
