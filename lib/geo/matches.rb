module Geo
  class Matches
    include Query

    def query
      { 'query' => { 'text_phrase_prefix' => { 'name' => term } } }
    end

  end
end
