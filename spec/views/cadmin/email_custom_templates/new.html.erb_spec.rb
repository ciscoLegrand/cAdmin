require 'rails_helper'

RSpec.describe "email_custom_templates/new", type: :view do
  before(:each) do
    assign(:email_custom_template, EmailCustomTemplate.new(
      content: "MyText",
      email_base_template: nil
    ))
  end

  it "renders new email_custom_template form" do
    render

    assert_select "form[action=?][method=?]", email_custom_templates_path, "post" do

      assert_select "textarea[name=?]", "email_custom_template[content]"

      assert_select "input[name=?]", "email_custom_template[email_base_template_id]"
    end
  end
end
