class WeathersController < ApplicationController
  # TODO: error handling

  def create
    @weather = Weather.fetch(geocoded_location)
  end

  private

  def geocoded_location
    Location.geocode(weather_params[:address])
  end

  def weather_params
    params.require(:weather).permit(:address)
  end
end
