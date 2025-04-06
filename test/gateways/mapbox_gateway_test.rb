require "test_helper"

class MapboxGatewayTest < ActiveSupport::TestCase
  def setup
    @gateway = MapboxGateway.new(client: MapboxGateway::ClientMock.new)
  end

  test "geocoding a valid location" do
    result = @gateway.geocode("974 2100 South")

    assert_equal "Salt Lake City", result.city
    assert_equal "Utah", result.state
    assert_equal 40.725163, result.latitude
    assert_equal -111.86313, result.longitude
  end

  test "geocoding an invalid location" do
    result = @gateway.geocode("error")
    assert_nil result
  end
end
