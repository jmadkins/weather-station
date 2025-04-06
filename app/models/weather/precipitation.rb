class Weather::Precipitation
  include ActiveModel::API

  attr_accessor :amount, :chance, :type
end
