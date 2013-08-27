module Geo
  class Search

    def initialize(env)
      @env = env
    end

    def response
      [status, headers, body]
    end

    def query
      env['REQUEST_URI'].gsub('/geo/','')
    end

    def status
      200
    end

    def headers
      { 'CONTENT-TYPE' => 'application/json' }
    end

    def body
      query
    end

    private

    attr_reader :env

  end
end
