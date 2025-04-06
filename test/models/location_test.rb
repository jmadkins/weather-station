require "test_helper"

class LocationTest < ActiveSupport::TestCase
  test "geocode" do
    skip "WIP"

    assert_nil Location.geocode "foo-bar"
    assert_not_nil Location.geocode "123 Main St"
  end
end
