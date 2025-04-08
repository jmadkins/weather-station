# Mapbox API Gateway
class MapboxGateway
  def initialize(client: MapboxGateway::Client.new)
    @client = client
  end

  # @param query [String] The user-provided location to geocode.
  # @return [MapboxGateway::GeocodeMatch, nil]
  def geocode(query)
    response = @client.search_geocode(query)
    return if response.nil?

    response[:features].each do |feature|
      # the presence of `match_code` indicates that _some_ part of our query was matched
      next if feature[:properties][:coordinates].nil? || feature[:properties][:match_code].nil?

      return MapboxGateway::GeocodeMatch.new(feature)
    end

    nil
  end
end
