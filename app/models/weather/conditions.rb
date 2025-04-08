class Weather::Conditions
  include ActiveModel::API

  # @return [ActiveSupport::TimeWithZone] Timestamp for when these conditions will start
  attr_accessor :start_at

  # @return [ActiveSupport::TimeWithZone] Timestamp of when these conditions will end
  attr_accessor :end_at

  # @return [String]
  attr_accessor :name

  # @return [Integer] Temperature in Celcius
  attr_accessor :temperature

  # @return [Integer] Percentage chance that it will rain
  attr_accessor :precipitation_chance

  # @return [String] A short human readable summary  of the weather
  attr_accessor :short_forecast

  # @return [String] A detailed human readable summary of the weather
  attr_accessor :detailed_forecast

  # @return [Float] Temperature in Fahrenheit
  def fahrenheit_temperature
    (temperature * 9 / 5.to_f) + 32
  end
end
