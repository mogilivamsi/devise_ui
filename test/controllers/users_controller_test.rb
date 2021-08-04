require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get login" do
    get users_login_url
    assert_response :success
  end

  test "should get signup" do
    get users_signup_url
    assert_response :success
  end

  test "should get forgot_password_new" do
    get users_forgot_password_url
    assert_response :success
  end

  test "should get reset_password" do
    get users_reset_password_url
    assert_response :success
  end

end
