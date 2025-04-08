require "test_helper"

class Weather::ConditionsTest < ActiveSupport::TestCase
  test "fahrenheit_temperature" do
    assert_equal 32, Weather::Conditions.new(temperature: 0).fahrenheit_temperature
    assert_equal 35.6, Weather::Conditions.new(temperature: 2).fahrenheit_temperature
    assert_equal 41, Weather::Conditions.new(temperature: 5).fahrenheit_temperature
    assert_equal 50, Weather::Conditions.new(temperature: 10).fahrenheit_temperature
  end
end
