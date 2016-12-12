require 'test_helper'

class MapsControllerTest < ActionController::TestCase
  test "should get maps_view" do
    get :maps_view
    assert_response :success
  end

end
