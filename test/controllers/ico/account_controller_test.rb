require 'test_helper'

class Ico::AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ico_account_index_url
    assert_response :success
  end

  test "should get add_eth" do
    get ico_account_add_eth_url
    assert_response :success
  end

end
