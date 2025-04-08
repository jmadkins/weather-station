class NWSGateway::Client
  GridPoints = Data.define(:grid_id, :point_x, :point_y)

  # @param latitude [Float] Must be rounded to the 4th digit
  # @param longitude [Float] Must be rounded to the 4th digit
  # @return [Hash, nil] JSON response parsed
  def points(latitude, longitude)
    response = api_connection.get("points/#{latitude},#{longitude}")
    response.body.with_indifferent_access
  rescue Faraday::Error => e
    Rails.logger.error "NWS API Error: #{e.message}"
    nil
  end

  # @param grid_points [GridPoints] Grid information
  # @param units [String] US customary or SI (metric) units in textual output
  # @return [Hash, nil] JSON response parsed
  def grid_forecast(grid_points, units = "si")
    response = api_connection.get("gridpoints/#{grid_points.grid_id}/#{grid_points.point_x},#{grid_points.point_y}/forecast", {units: units})
    response.body.with_indifferent_access
  rescue Faraday::Error => e
    Rails.logger.error "NWS API Error: #{e.message}"
    nil
  end

  private

  # @return [Faraday::Connection]
  def api_connection
    @api_connection ||= Faraday.new(url: "https://api.weather.gov", headers: {"Accept" => "application/ld+json"}) do |f|
      f.response :json
      f.response :raise_error
    end
  end
end
