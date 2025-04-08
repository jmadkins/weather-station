require "test_helper"

class WeatherTest < ActiveSupport::TestCase
  test "reads from cache" do
    location = Location.new(
      display: "Test location",
      postal_code: "43214",
      latitude: 10,
      longitude: 12
    )
    forecast = [
      Weather::Conditions.new(
        start_at: Time.zone.now,
        end_at: 1.hour.from_now,
        temperature: 21
      )
    ]
    Rails.cache.write("#{location.cache_key}/forecast", forecast, expires_in: 30.minutes)

    results = Weather.fetch(location)
    assert results.cached
    assert_not_nil results.current_conditions
    assert_equal 0, results.forecast.size
  end
end
