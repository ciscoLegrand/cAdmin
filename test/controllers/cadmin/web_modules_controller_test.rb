require "test_helper"

module Cadmin
  class WebModulesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @web_module = cadmin_web_modules(:one)
    end

    test "should get index" do
      get web_modules_url
      assert_response :success
    end

    test "should get new" do
      get new_web_module_url
      assert_response :success
    end

    test "should create web_module" do
      assert_difference('WebModule.count') do
        post web_modules_url, params: { web_module: { adyen: @web_module.adyen, blog: @web_module.blog, gallery: @web_module.gallery, newsletter: @web_module.newsletter, opinions: @web_module.opinions, paypal: @web_module.paypal, reservation: @web_module.reservation, stripe: @web_module.stripe } }
      end

      assert_redirected_to web_module_url(WebModule.last)
    end

    test "should show web_module" do
      get web_module_url(@web_module)
      assert_response :success
    end

    test "should get edit" do
      get edit_web_module_url(@web_module)
      assert_response :success
    end

    test "should update web_module" do
      patch web_module_url(@web_module), params: { web_module: { adyen: @web_module.adyen, blog: @web_module.blog, gallery: @web_module.gallery, newsletter: @web_module.newsletter, opinions: @web_module.opinions, paypal: @web_module.paypal, reservation: @web_module.reservation, stripe: @web_module.stripe } }
      assert_redirected_to web_module_url(@web_module)
    end

    test "should destroy web_module" do
      assert_difference('WebModule.count', -1) do
        delete web_module_url(@web_module)
      end

      assert_redirected_to web_modules_url
    end
  end
end
