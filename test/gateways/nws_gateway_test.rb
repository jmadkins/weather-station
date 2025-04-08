require "test_helper"

class NWSGatewayTest < ActiveSupport::TestCase
  def setup
    @gateway = NWSGateway.new(client: NWSGateway::ClientMock.new)
  end
end
