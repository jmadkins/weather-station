class ForecastsController < ApplicationController
  def create
    @params = params.require(:forecast).permit(:address)
  end
end
