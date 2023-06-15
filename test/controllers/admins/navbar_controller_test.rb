require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count') do
      post admins_url, params: { admin: { email: 'test@example.com', password: 'password' } }
    end

    assert_redirected_to root_url
  end
end
