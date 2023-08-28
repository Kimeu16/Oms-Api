require "test_helper"

class CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @check_in = check_ins(:one)
  end

  test "should get index" do
    get check_ins_url, as: :json
    assert_response :success
  end

  test "should create check_in" do
    assert_difference("CheckIn.count") do
      post check_ins_url, params: { check_in: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show check_in" do
    get check_in_url(@check_in), as: :json
    assert_response :success
  end

  test "should update check_in" do
    patch check_in_url(@check_in), params: { check_in: {  } }, as: :json
    assert_response :success
  end

  test "should destroy check_in" do
    assert_difference("CheckIn.count", -1) do
      delete check_in_url(@check_in), as: :json
    end

    assert_response :no_content
  end
end
