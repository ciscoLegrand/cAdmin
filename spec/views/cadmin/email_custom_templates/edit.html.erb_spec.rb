require 'rails_helper'

RSpec.describe "email_custom_templates/edit", type: :view do
  before(:each) do
    @email_custom_template = assign(:email_custom_template, EmailCustomTemplate.create!(
      content: "MyText",
      email_base_template: nil
    ))
  end

  it "renders the edit email_custom_template form" do
    render

    assert_select "form[action=?][method=?]", email_custom_template_path(@email_custom_template), "post" do

      assert_select "textarea[name=?]", "email_custom_template[content]"

      assert_select "input[name=?]", "email_custom_template[email_base_template_id]"
    end
  end
end
