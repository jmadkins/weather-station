class MapboxGateway::Client
  # @param [String] address
  # @return [Hash] JSON response parsed
  def search_geocode(address, country = "US")
    response = api_connection.get("search/geocode/v6/forward", {q: address, country: country, access_token: access_token})
    response.body.with_indifferent_access
  rescue Faraday::Error => e
    Rails.logger.error "Mapbox API Error: #{e.message}"
    nil
  end

  private

  # @return [Faraday::Connection]
  def api_connection
    @api_connection ||= Faraday.new(url: "https://api.mapbox.com") do |f|
      f.response :json
      f.response :raise_error
    end
  end

  # @return [String]
  def access_token
    ENV["WS_MAPBOX_ACCESS_TOKEN"]
  end
end
