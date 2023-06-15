require 'test_helper'

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: 'test@example.com', password: 'password' } }
    end

    assert_redirected_to root_url
  end
end
