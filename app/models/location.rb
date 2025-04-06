class Location
  include ActiveModel::API

  attr_accessor :display, :zip_code, :latitude, :longitude

  def self.geocode(address)
    response = MapboxGateway.new.geocode(address)
    return if response.nil?

    new(
      display: "#{response.city}, #{response.state}",
      zip_code: response.zip_code,
      latitude: response.latitude,
      longitude: response.longitude
    )
  end

  def cacheable?
    zip_code.present?
  end

  def cache_key
    zip_code
  end
end
