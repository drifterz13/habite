require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    sign_in(user)
  end

  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get shop page" do
    get pages_shop_url
    assert_response :success
  end
end
