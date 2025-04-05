require "test_helper"

class ForecastsControllerTest < ActionDispatch::IntegrationTest
  test "create" do
    post forecasts_url, params: {forecast: {address: "123 Main St"}, format: :turbo_stream}
    assert_response :success
    assert_dom "p", "123 Main St"
  end
end
