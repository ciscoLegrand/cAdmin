require "rails_helper"

module Cadmin
  RSpec.describe EmailBaseTemplatesController, type: :routing do
    describe "routing" do
      it "routes to #index" do
        expect(get: "/email_base_templates").to route_to("email_base_templates#index")
      end

      it "routes to #new" do
        expect(get: "/email_base_templates/new").to route_to("email_base_templates#new")
      end

      it "routes to #show" do
        expect(get: "/email_base_templates/1").to route_to("email_base_templates#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/email_base_templates/1/edit").to route_to("email_base_templates#edit", id: "1")
      end


      it "routes to #create" do
        expect(post: "/email_base_templates").to route_to("email_base_templates#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/email_base_templates/1").to route_to("email_base_templates#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/email_base_templates/1").to route_to("email_base_templates#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/email_base_templates/1").to route_to("email_base_templates#destroy", id: "1")
      end
    end
  end
end
