class NWSGateway::Forecast
  def initialize(raw_data)
    @name = raw_data[:name]
    @start_time = Time.parse raw_data[:startTime]
    @end_time = Time.parse raw_data[:endTime]
    @temperature = raw_data[:temperature]
    @short = raw_data[:shortForecast]
    @detailed = raw_data[:detailedForecast]
    @icon = raw_data[:icon]
  end

  attr_reader :name, :start_time, :end_time, :temperature, :short, :detailed, :icon
end
