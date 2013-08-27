require 'spec_helper'
require 'geo/configuration'

module Geo
  describe Configuration do
    it 'configures the elastic search domain' do
      expect(Configuration.elastic_search_domain).to eq 'localhost:9200'
    end
  end
end
