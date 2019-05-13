require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest

  test "going to pages/home leads to home page" do
    get pages_home_url
    assert_response :success
  end

  test "going to root page lead to home page" do
    get root_url
    assert_response :success
  end
end
