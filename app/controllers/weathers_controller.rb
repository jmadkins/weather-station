class WeathersController < ApplicationController
  def create
    @weather = Weather.fetch(geocoded_location)
    render :try_again if @weather.location.nil? || @weather.current_conditions.nil?
  end

  private

  def geocoded_location
    Location.geocode(weather_params[:address])
  end

  def weather_params
    params.require(:weather).permit(:address)
  end
end
