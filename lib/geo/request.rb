module Geo
  class Request

    def initialize(env)
      @env = env
    end

    def response
      [status, headers, body]
    end

    def query
      env['REQUEST_URI'].gsub('/geo/', '')
    end

    def status
      200
    end

    def headers
      { 'Content-Type' => 'application/json' }
    end

    def body
      { matches: matches }
    end

    private

    attr_reader :env

    def matches
      Matches.new(query).results
    end
  end
end
