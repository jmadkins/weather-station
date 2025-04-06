class Weather::Current
  include ActiveModel::API

  attr_accessor :temperature, :precipitation, :timestamp
end
