require 'test_helper'

class AtriclesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
