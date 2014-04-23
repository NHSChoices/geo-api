module Geo
  class Matches
    include Query

    def query
      { 'query' => { 'match_phrase_prefix' => { 'name' => term } } }
    end
  end
end
