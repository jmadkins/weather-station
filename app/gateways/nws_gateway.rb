# National Weather Service API Gateway
class NWSGateway
  def initialize(client: NWSGateway::Client.new)
    @client = client
  end

  # @param latitude [Float]
  # @param longitude [Float]
  # @return [Array<NWSGateway::Forecast>]
  def forecast(latitude, longitude)
    grid_points = fetch_grid_points_for_lat_long(latitude.round(4), longitude.round(4))
    return if grid_points.nil?
    grid_forecast = @client.grid_forecast(grid_points)
    return if grid_forecast.nil?

    grid_forecast[:periods].map { |p| Forecast.new(p) }
  end

  private

  # NWS recommends caching grid points but cautions that they can change
  def fetch_grid_points_for_lat_long(latitude, longitude)
    Rails.cache.fetch("nws/points/#{latitude},#{longitude}", expires_in: 72.hours, skip_nil: true) do
      points_response = @client.points(latitude, longitude)
      return if points_response.nil?

      NWSGateway::Client::GridPoints.new(
        grid_id: points_response[:gridId],
        point_x: points_response[:gridX],
        point_y: points_response[:gridY]
      )
    end
  end
end
