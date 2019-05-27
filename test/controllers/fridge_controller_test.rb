require 'test_helper'

class FridgeControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get fridge_show_url
    assert_response :success
  end

end
