require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get home" do
    get pages_home_url
    assert_response :success
  end
end
