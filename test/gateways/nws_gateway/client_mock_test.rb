require "test_helper"

class NWSGateway::ClientMockTest < ActiveSupport::TestCase
  test "returns mocked results" do
    client = NWSGateway::ClientMock.new

    assert_nil client.points(0,0)
    assert_not_nil client.points(1,1)

    assert_nil client.grid_forecast(0,0)
    assert_not_nil client.grid_forecast(1,1)
  end
end
