class MapboxGateway::ClientMock
  # @param [String] address
  # @return [Hash] Mocked JSON response parsed
  def search_geocode(address)
    return if address == "error"

    JSON.parse(
      File.read(Rails.root.join("test/fixtures/files/mapbox/forward_geocode/success.json")),
      symbolize_names: true
    )
  end
end
