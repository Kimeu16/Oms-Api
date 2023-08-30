require "test_helper"

class CheckInOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @check_in_out = check_in_outs(:one)
  end

  test "should get index" do
    get check_in_outs_url, as: :json
    assert_response :success
  end

  test "should create check_in_out" do
    assert_difference("CheckInOut.count") do
      post check_in_outs_url, params: { check_in_out: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show check_in_out" do
    get check_in_out_url(@check_in_out), as: :json
    assert_response :success
  end

  test "should update check_in_out" do
    patch check_in_out_url(@check_in_out), params: { check_in_out: {  } }, as: :json
    assert_response :success
  end

  test "should destroy check_in_out" do
    assert_difference("CheckInOut.count", -1) do
      delete check_in_out_url(@check_in_out), as: :json
    end

    assert_response :no_content
  end
end
