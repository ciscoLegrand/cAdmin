require "application_system_test_case"

module Cadmin
  class WebModulesTest < ApplicationSystemTestCase
    setup do
      @web_module = cadmin_web_modules(:one)
    end

    test "visiting the index" do
      visit web_modules_url
      assert_selector "h1", text: "Web Modules"
    end

    test "creating a Web module" do
      visit web_modules_url
      click_on "New Web Module"

      check "Adyen" if @web_module.adyen
      check "Blog" if @web_module.blog
      check "Gallery" if @web_module.gallery
      check "Newsletter" if @web_module.newsletter
      check "Opinions" if @web_module.opinions
      check "Paypal" if @web_module.paypal
      check "Reservation" if @web_module.reservation
      check "Stripe" if @web_module.stripe
      click_on "Create Web module"

      assert_text "Web module was successfully created"
      click_on "Back"
    end

    test "updating a Web module" do
      visit web_modules_url
      click_on "Edit", match: :first

      check "Adyen" if @web_module.adyen
      check "Blog" if @web_module.blog
      check "Gallery" if @web_module.gallery
      check "Newsletter" if @web_module.newsletter
      check "Opinions" if @web_module.opinions
      check "Paypal" if @web_module.paypal
      check "Reservation" if @web_module.reservation
      check "Stripe" if @web_module.stripe
      click_on "Update Web module"

      assert_text "Web module was successfully updated"
      click_on "Back"
    end

    test "destroying a Web module" do
      visit web_modules_url
      page.accept_confirm do
        click_on "Destroy", match: :first
      end

      assert_text "Web module was successfully destroyed"
    end
  end
end
