class Forecast
  # Fetches weather conditions for given latitude/longitude position
  #
  # @param latitude [Float]
  # @param longitude [Float]
  # @return [Array<Weather::Conditions>]
  def self.fetch(latitude, longitude)
    # NOTE: After additional weather providers are introduced, this logic would change a bit
    # forecast = Forecast::Fetcher.execute(latitude, longitude)
    forecast = NWSGateway.new.forecast(latitude, longitude)
    return if forecast.nil?

    forecast.map do |f|
      Weather::Conditions.new(
        name: f.name,
        start_at: f.start_time,
        end_at: f.end_time,
        temperature: f.temperature,
        short_forecast: f.short,
        detailed_forecast: f.detailed
      )
    end
  end
end
