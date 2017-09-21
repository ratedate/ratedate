require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get in_develop" do
    get static_pages_in_develop_url
    assert_response :success
  end

end
