require 'test_helper'

class PersonalMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get personal_messages_create_url
    assert_response :success
  end

  test "should get new" do
    get personal_messages_new_url
    assert_response :success
  end

end
