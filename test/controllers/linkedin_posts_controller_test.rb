require "test_helper"

class LinkedinPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get linkedin_posts_index_url
    assert_response :success
  end

  test "should get create" do
    get linkedin_posts_create_url
    assert_response :success
  end
end
