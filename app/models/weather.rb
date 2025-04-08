class Weather
  include ActiveModel::API

  # Provides weather conditions and forecasts from a given {Location}
  #
  # @param location [Location] The location you'd like to fetch weather data for.
  # @return [Weather]
  def self.fetch(location)
    return new(cached: false) if location.nil?

    if (forecast = Rails.cache.read("#{location.cache_key}/forecast"))
      current_conditions = forecast.shift
      return new(location: location, current_conditions: current_conditions, forecast: forecast, cached: true)
    end

    forecast = Forecast.fetch(location.latitude, location.longitude)
    return new(location: location, cached: false) if forecast.nil?

    Rails.cache.write("#{location.cache_key}/forecast", forecast, expires_in: 30.minutes)
    current_conditions = forecast.shift
    new(location: location, current_conditions: current_conditions, forecast: forecast, cached: false)
  end

  # @return [Boolean] True when the data is fetched from cache.
  attr_accessor :cached

  # @return [Weather::Conditions] Current weather conditions
  attr_accessor :current_conditions

  # @return [Array<Weather::Conditions>] Forecasted weather conditions
  attr_accessor :forecast

  # @return [Location] The location for which the weather data was fetched.
  attr_accessor :location
end
