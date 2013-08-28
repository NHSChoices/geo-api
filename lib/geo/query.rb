module Geo
  ##
  # Geo::Query
  # Classes that include this module must provide a #query method
  ##
  module Query

    def initialize(term)
      @term = term
    end

    def url
      "http://#{domain}/_search"
    end

    def results
      @results ||= response['hits']['hits'].map(&Extractor)
    end

    def response
      Yajl::Parser.parse(request.response)
    end

    def encoded_query
      Yajl::Encoder.encode(query)
    end

    def request
      EM::HttpRequest.new(url).get(body: encoded_query)
    end

    private

    def domain
      Configuration.elastic_search_domain
    end

    attr_reader :term
  end
end

