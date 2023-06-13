require "test_helper"

class LeaveTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @leave_type = leave_types(:one)
  end

  test "should get index" do
    get leave_types_url, as: :json
    assert_response :success
  end

  test "should create leave_type" do
    assert_difference("LeaveType.count") do
      post leave_types_url, params: { leave_type: { days_allowed: @leave_type.days_allowed, name: @leave_type.name } }, as: :json
    end

    assert_response :created
  end

  test "should show leave_type" do
    get leave_type_url(@leave_type), as: :json
    assert_response :success
  end

  test "should update leave_type" do
    patch leave_type_url(@leave_type), params: { leave_type: { days_allowed: @leave_type.days_allowed, name: @leave_type.name } }, as: :json
    assert_response :success
  end

  test "should destroy leave_type" do
    assert_difference("LeaveType.count", -1) do
      delete leave_type_url(@leave_type), as: :json
    end

    assert_response :no_content
  end
end
