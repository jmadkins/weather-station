require "test_helper"

class WeathersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @location = Location.new(display: "Salt Lake City, Utah", postal_code: "84106", latitude: 40.725163, longitude: -111.86313)
    @weather = Weather.new(
      cached: false,
      current_conditions: Weather::Conditions.new(
        start_at: Time.zone.now,
        end_at: 1.hour.from_now,
        temperature: 21
      ),
      forecast: [],
      location: @location
    )
    Rails.cache.delete "84106/forecast"
  end

  test "fetching weather successfully" do
    Location.stub :geocode, @weather.location do
      Forecast.stub :fetch, [@weather.current_conditions] do
        post weather_url, params: {weather: {address: "974 2100 South"}, format: :turbo_stream}
        assert_response :success
        assert_dom "h3", "Extended Forecast"
      end
    end
  end

  test "invalid addresses return an error" do
    Location.stub :geocode, nil do
      post weather_url, params: {weather: {address: "974 2100 South"}, format: :turbo_stream}
      assert_response :success
      assert_dom "div", "Unable to find the requested location. Please try again."
    end
  end

  test "no weather data returns an error" do
    Location.stub :geocode, @weather.location do
      Forecast.stub :fetch, nil do
        post weather_url, params: {weather: {address: "974 2100 South"}, format: :turbo_stream}
        assert_response :success
        assert_dom "div", "No weather data available for the requested location. Please try again."
      end
    end
  end
end
