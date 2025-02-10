require "test_helper"

class GossipsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gossips_show_url
    assert_response :success
  end
end
