class NWSGateway::ClientMock
  # @param latitude [Float] Must be rounded to the 4th digit
  # @param longitude [Float] Must be rounded to the 4th digit
  # @return [Hash] JSON response parsed
  def points(latitude, longitude)
    return nil if latitude.zero? || longitude.zero?

    JSON.parse(
      File.read(Rails.root.join("test/fixtures/files/nws/points/success.json")),
      symbolize_names: true
    )
  end

  def grid_forecast(point_x, point_y, units = "si")
    return nil if point_x.zero? || point_y.zero?

    JSON.parse(
      File.read(Rails.root.join("test/fixtures/files/nws/grid_forecast/success.json")),
      symbolize_names: true
    )
  end
end
