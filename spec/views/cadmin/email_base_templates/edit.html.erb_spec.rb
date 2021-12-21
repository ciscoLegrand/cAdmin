require 'rails_helper'

RSpec.describe "email_base_templates/edit", type: :view do
  before(:each) do
    @email_base_template = assign(:email_base_template, EmailBaseTemplate.create!())
  end

  it "renders the edit email_base_template form" do
    render

    assert_select "form[action=?][method=?]", email_base_template_path(@email_base_template), "post" do
    end
  end
end
