class Forecast
  include ActiveModel::API

  def self.fetch(latitude, longitude)
    nil
  end

  # @return [Weather::Current] The current weather conditions.
  attr_accessor :current_conditions

  # @return [Hash<ActiveSupport::TimeWithZone, Weather::Conditions>] The forecast for the next few days.
  attr_accessor :daily_forecast
end
