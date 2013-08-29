require 'spec_helper'

module Geo
  describe Alternatives do

    let (:alternatives) { Alternatives.new('Leads') }

    it 'queries elasticsearch for fuzzy matches' do
      expect(alternatives.query).to eq ({
        'query' =>
        { 'fuzzy' =>
          { 'name' =>
            {
              'value' => 'Leads',
              'boost' => 1.0,
              'min_similarity' => 0.75,
              'prefix_length' => 2
            }
          }
        }
      })
    end
  end
end
