class WeatherController < ApplicationController
  def create
    # response = MapboxGateway.new.geocode(weather_params[:address])
    # location = Location.new_from_geocode(response)
    # @weather = Weather.fetch(@location)

    @params = weather_params
  end

  private

  def weather_params
    params.require(:weather).permit(:address)
  end
end
