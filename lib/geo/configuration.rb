require 'yamlig'

module Geo
  class Configuration
    include Yamlig::Config

    property :elastic_search_domain

    path 'config/geo.yml', Goliath.env
  end
end
