require "test_helper"

class WeathersControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    location = Location.new(display: "Salt Lake City, Utah", zip_code: "84106", latitude: 40.725163, longitude: -111.86313)

    Location.stub :geocode, location do
      post weather_url, params: {weather: {address: "974 2100 South"}, format: :turbo_stream}
      assert_response :success
      assert_dom "p", "Salt Lake City, Utah"
    end
  end
end
