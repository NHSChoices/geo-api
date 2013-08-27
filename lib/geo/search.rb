module Geo
  class Search

    def initialize(env)
      @env = env
    end

    def response
      [200, {}, query]
    end

    def query
      env['REQUEST_URI'].gsub('/geo/','')
    end

    private

    attr_reader :env

  end
end
