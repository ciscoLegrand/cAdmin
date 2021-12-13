require 'rails_helper'

RSpec.describe "event_types/show", type: :view do
  before(:each) do
    @event_type = assign(:event_type, EventType.create!(
      name: "Name",
      salary: 2.5,
      overtime_pay: 3.5,
      assemble: 4.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
  end
end
