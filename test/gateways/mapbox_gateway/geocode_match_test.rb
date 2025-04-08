require "test_helper"

class MapboxGateway::GeocodeMatchTest < ActiveSupport::TestCase
  test "parses Feature from Mapbox Geocoding API" do
    raw_data = MapboxGateway::ClientMock.new.search_geocode "success"
    reply = MapboxGateway::GeocodeMatch.new(raw_data[:features].first)

    assert_equal "Salt Lake City", reply.city
    assert_equal "Utah", reply.state
    assert_equal "84106", reply.postal_code
    assert_equal 40.725163, reply.latitude
    assert_equal(-111.86313, reply.longitude)
  end
end
