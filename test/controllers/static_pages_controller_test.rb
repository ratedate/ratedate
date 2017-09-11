require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get ico_landing" do
    get static_pages_ico_landing_url
    assert_response :success
  end

end
