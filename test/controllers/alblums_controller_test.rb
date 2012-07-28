require "minitest_helper"

describe AlblumsController do
  it "should get show" do
    get :show
    assert_response :success
  end

  it "should get index" do
    get :index
    assert_response :success
  end

end
