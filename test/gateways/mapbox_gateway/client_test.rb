require "test_helper"

class MapboxGateway::ClientTest < ActiveSupport::TestCase
  def setup
    @client = MapboxGateway::Client.new
  end

  test "successful responses" do
    stub_request(:get, "https://api.mapbox.com/search/geocode/v6/forward")
      .with(query: {q: "974 2100 South", access_token: ENV["WS_MAPBOX_ACCESS_TOKEN"], country: "US"})
      .to_return_json(
        body: JSON.parse(file_fixture("mapbox/forward_geocode/success.json").read)
      )

    response = @client.search_geocode("974 2100 South")

    assert_not_nil response
    assert_equal 2, response[:features].size
  end

  test "unsuccessful responses" do
    stub_request(:get, "https://api.mapbox.com/search/geocode/v6/forward")
      .with(query: {q: "974 2100 South", access_token: ENV["WS_MAPBOX_ACCESS_TOKEN"], country: "US"})
      .to_return(status: [401, "Unauthorized"])

    assert_nil @client.search_geocode("974 2100 South")
  end

  test "timeouts" do
    stub_request(:get, "https://api.mapbox.com/search/geocode/v6/forward")
      .with(query: {q: "974 2100 South", access_token: ENV["WS_MAPBOX_ACCESS_TOKEN"], country: "US"})
      .to_timeout

    assert_nil @client.search_geocode("974 2100 South")
  end
end
