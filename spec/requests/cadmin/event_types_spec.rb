 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

module Cadmin
  RSpec.describe "/event_types", type: :request do
        include Engine.routes.url_helpers
  
    # EventType. As you add validations to EventType, be sure to
    # adjust the attributes here as well.
    let(:valid_attributes) {
      {name: 'boda', salary: 160.00, overtime_price: 40.00,assemble: 0.00}
      # skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      {name: 150, salary: '160.00', overtime_price: '40.00',assemble:'0.00'}
      # skip("Add a hash of attributes invalid for your model")
    }

    describe "GET /index" do
      it "renders a successful response" do
        EventType.create! valid_attributes
        get event_types_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        event_type = EventType.create! valid_attributes
        get event_type_url(event_type)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_event_type_url
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "render a successful response" do
        event_type = EventType.create! valid_attributes
        get edit_event_type_url(event_type)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new EventType" do
          expect {
            post event_types_url, params: { event_type: valid_attributes }
          }.to change(EventType, :count).by(1)
        end

        it "redirects to the created event_type" do
          post event_types_url, params: { event_type: valid_attributes }
          expect(response).to redirect_to(event_type_url(EventType.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new EventType" do
          expect {
            post event_types_url, params: { event_type: invalid_attributes }
          }.to change(EventType, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post event_types_url, params: { event_type: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          {name: 'comunion', salary: 80.00, overtime_price: 20.00,assemble: 20.00}
        }

        it "updates the requested event_type" do
          event_type = EventType.create! valid_attributes
          patch event_type_url(event_type), params: { event_type: new_attributes }
          event_type.reload
          skip("Add assertions for updated state")
        end

        it "redirects to the event_type" do
          event_type = EventType.create! valid_attributes
          patch event_type_url(event_type), params: { event_type: new_attributes }
          event_type.reload
          expect(response).to redirect_to(event_type_url(event_type))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          event_type = EventType.create! valid_attributes
          patch event_type_url(event_type), params: { event_type: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested event_type" do
        event_type = EventType.create! valid_attributes
        expect {
          delete event_type_url(event_type)
        }.to change(EventType, :count).by(-1)
      end

      it "redirects to the event_types list" do
        event_type = EventType.create! valid_attributes
        delete event_type_url(event_type)
        expect(response).to redirect_to(event_types_url)
      end
    end
  end
end
