module Requests
  module JsonHelpers
    def symbolize_json(body)
      JSON.parse(body, symbolize_names: true)
    end
  end
end