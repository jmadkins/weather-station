class MapboxGateway::GeocodeMatch
  def initialize(raw_data)
    @raw_data = raw_data
  end

  attr_reader :raw_data

  def latitude
    @latitude ||= raw_data[:properties][:coordinates][:latitude]
  end

  def longitude
    @longitude ||= raw_data[:properties][:coordinates][:longitude]
  end

  def city
    @city ||= context(:place)[:name]
  end

  def state
    @state ||= context(:region)[:name]
  end

  def zip_code
    @zip_code ||= context(:postcode)[:name]
  end

  private

  def context(id)
    @raw_data[:properties][:context][id] || {}
  end
end
