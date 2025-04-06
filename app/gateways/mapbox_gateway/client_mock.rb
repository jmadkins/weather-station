class MapboxGateway::ClientMock
  def search_geocode(address)
    return if address == "error"

    JSON.parse(
      File.read(Rails.root.join("test/fixtures/files/mapbox/forward_geocode/success.json")),
      symbolize_names: true
    )
  end
end
