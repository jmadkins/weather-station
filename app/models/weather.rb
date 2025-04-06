class Weather
  include ActiveModel::API

  # Fetches weather data for a given location.
  #
  # @param location [Location] The location you'd like to fetch weather data for.
  # @return [Weather] A new instance of Weather with the fetched data.
  def self.fetch(location)
    return if location.nil?
    forecast = Rails.cache.read("#{location.cache_key}/weather")

    if forecast
      new(location: location, forecast: forecast, cached: true)
    else
      forecast = Forecast.fetch(location.latitude, location.longitude)
      Rails.cache.write("#{location.cache_key}/weather", forecast, expires_in: 30.minutes) unless forecast.nil?
      new(location: location, forecast: forecast, cached: false)
    end
  end

  # @return [Boolean] Whether the data was fetched from the cache.
  attr_accessor :cached

  # @return [Forecast] The location for which the weather data was fetched.
  attr_accessor :forecast

  # @return [Location] The location for which the weather data was fetched.
  attr_accessor :location
end
