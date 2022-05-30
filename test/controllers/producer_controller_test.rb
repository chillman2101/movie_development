require "test_helper"

class ProducerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get producer_index_url
    assert_response :success
  end
end
