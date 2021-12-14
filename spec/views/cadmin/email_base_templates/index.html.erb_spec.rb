require 'rails_helper'

RSpec.describe "email_base_templates/index", type: :view do
  before(:each) do
    assign(:email_base_templates, [
      EmailBaseTemplate.create!(),
      EmailBaseTemplate.create!()
    ])
  end

  it "renders a list of email_base_templates" do
    render
  end
end
