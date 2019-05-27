require 'test_helper'

class GroceryListsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get grocery_lists_show_url
    assert_response :success
  end

end
