module AsyncHelper

  attr_reader :response

  def get(api, url)
    with_api api do
      get_request(path: url) do |request|
        self.response = Yajl::Parser.parse(request.response)
      end
    end
    wait_for_response
  end

  def matched_locations
    matches.map { |m| m.fetch('name') }
  end

  def matches
    response.fetch('matches')
  end

  private

  def wait_for_response(tries = 10)
    if tries > 0 && response.nil?
      sleep 0.1
      wait_for_response(tries - 1)
    elsif tries <=0
      fail "Waited too long for response"
    end
  end

  attr_writer :response
end

World(AsyncHelper)
