require "test_helper"

class NewsletterSubscriberControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get newsletter_subscriber_new_url
    assert_response :success
  end

  test "should get create" do
    get newsletter_subscriber_create_url
    assert_response :success
  end

  test "should get destroy" do
    get newsletter_subscriber_destroy_url
    assert_response :success
  end
end
