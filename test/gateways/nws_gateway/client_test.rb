require "test_helper"

class NWSGateway::ClientTest < ActiveSupport::TestCase
  def setup
    @client = NWSGateway::Client.new
  end

  test "successful points responses" do
    stub_request(:get, "https://api.weather.gov/points/39.7456,-97.0892")
      .to_return_json(
        body: JSON.parse(file_fixture("nws/points/success.json").read)
      )

    response = @client.points(39.7456, -97.0892)
    assert_not_nil response
  end

  test "successful grid_forecast responses" do
    stub_request(:get, "https://api.weather.gov/gridpoints/TOP/32,81/forecast")
      .with(query: {units: "us"})
      .to_return_json(
        body: JSON.parse(file_fixture("nws/grid_forecast/success.json").read)
      )

    points = NWSGateway::Client::GridPoints.new(
      grid_id: "TOP",
      point_x: 32,
      point_y: 81
    )
    response = @client.grid_forecast(points, "us")
    assert_not_nil response
  end
end
