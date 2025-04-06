class Weather::Conditions
  include ActiveModel::API

  attr_accessor :high, :low, :precipitation
end
