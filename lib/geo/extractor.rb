module Geo
  class Extractor
    def initialize(result)
      @result = result
    end

    def extracted
      {
        id: result.fetch('_id'),
        name: name,
        latitude: source.fetch('latitude'),
        longitude: source.fetch('longitude'),
        type: type
      }
    end

    def self.to_proc
      ->(result) { new(result).extracted }
    end

    private

    def source
      result.fetch('_source')
    end

    def name
      return source.fetch('name').join(', ') if type == 'place'
      source.fetch('name').first
    end

    def type
      result.fetch('_type')
    end

    attr_reader :result
  end
end
