require 'rails_helper'

RSpec.describe "email_base_templates/show", type: :view do
  before(:each) do
    @email_base_template = assign(:email_base_template, EmailBaseTemplate.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
