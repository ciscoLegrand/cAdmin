require 'rails_helper'

RSpec.describe "email_custom_templates/index", type: :view do
  before(:each) do
    assign(:email_custom_templates, [
      EmailCustomTemplate.create!(
        content: "MyText",
        email_base_template: nil
      ),
      EmailCustomTemplate.create!(
        content: "MyText",
        email_base_template: nil
      )
    ])
  end

  it "renders a list of email_custom_templates" do
    render
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
