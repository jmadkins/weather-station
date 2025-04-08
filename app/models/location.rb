class Location
  include ActiveModel::API

  # Retrieve the latitude and longitude positions for an address
  #
  # @param address [String]
  # @return [Location, nil]
  def self.geocode(address)
    # NOTE: We currently only support Mapbox but can easily switch to others
    response = MapboxGateway.new.geocode(address)
    return if response.nil?

    new(
      display: "#{response.city}, #{response.state}",
      postal_code: response.postal_code,
      latitude: response.latitude,
      longitude: response.longitude
    )
  end

  # @return [String]
  attr_accessor :display

  # @return [String]
  attr_accessor :postal_code

  # @return [Float]
  attr_accessor :latitude

  # @return [Float]
  attr_accessor :longitude

  def cache_key
    postal_code
  end
end
