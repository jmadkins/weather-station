require "test_helper"

class MapboxGateway::ClientMockTest < ActiveSupport::TestCase
  test "returns mocked results" do
    client = MapboxGateway::ClientMock.new

    assert_nil client.search_geocode("error")
    assert_not_nil client.search_geocode("not error")
  end
end
