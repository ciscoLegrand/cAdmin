require 'rails_helper'

RSpec.describe "email_custom_templates/show", type: :view do
  before(:each) do
    @email_custom_template = assign(:email_custom_template, EmailCustomTemplate.create!(
      content: "MyText",
      email_base_template: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
