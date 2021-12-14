require 'rails_helper'

RSpec.describe "email_base_templates/new", type: :view do
  before(:each) do
    assign(:email_base_template, EmailBaseTemplate.new())
  end

  it "renders new email_base_template form" do
    render

    assert_select "form[action=?][method=?]", email_base_templates_path, "post" do
    end
  end
end
