module Geo
  class Alternatives
    include Query

    def query
      { 'query' => { 'fuzzy' => { 'name' =>
        {
          'value' => term,
          'boost' => 1.0,
          'fuzziness' => 2,
          'prefix_length' => 2
        } } } }
    end

  end
end
