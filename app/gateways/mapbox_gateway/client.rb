class MapboxGateway::Client
  # @param [String] address
  # @return [Hash]
  def search_geocode(address)
    response = api_connection.get("search/geocode/v6/forward", {q: address, access_token: access_token})

    unless response.success?
      Rails.logger.error "Mapbox API Error: #{response.status} - #{response.body}"
      return
    end

    response.body.with_indifferent_access
  rescue Faraday::ConnectionFailed
    Rails.logger.error("Mapbox API Error: Timeout")
    nil
  end

  private

  # @return [Faraday::Connection]
  def api_connection
    @api_connection ||= Faraday.new(url: "https://api.mapbox.com") do |f|
      f.response :json
    end
  end

  # @return [String]
  def access_token
    ENV["WS_MAPBOX_ACCESS_TOKEN"]
  end
end
