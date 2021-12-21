require "rails_helper"

module Cadmin
  RSpec.describe EmailCustomTemplatesController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/email_custom_templates").to route_to("email_custom_templates#index")
      end

      it "routes to #new" do
        expect(get: "/email_custom_templates/new").to route_to("email_custom_templates#new")
      end

      it "routes to #show" do
        expect(get: "/email_custom_templates/1").to route_to("email_custom_templates#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/email_custom_templates/1/edit").to route_to("email_custom_templates#edit", id: "1")
      end


      it "routes to #create" do
        expect(post: "/email_custom_templates").to route_to("email_custom_templates#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/email_custom_templates/1").to route_to("email_custom_templates#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/email_custom_templates/1").to route_to("email_custom_templates#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/email_custom_templates/1").to route_to("email_custom_templates#destroy", id: "1")
      end
    end
  end
end
