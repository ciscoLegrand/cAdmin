require 'rails_helper'

RSpec.describe "event_types/index", type: :view do
  before(:each) do
    assign(:event_types, [
      EventType.create!(
        name: "Name",
        salary: 2.5,
        overtime_pay: 3.5,
        assemble: 4.5
      ),
      EventType.create!(
        name: "Name",
        salary: 2.5,
        overtime_pay: 3.5,
        assemble: 4.5
      )
    ])
  end

  it "renders a list of event_types" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: 2.5.to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
    assert_select "tr>td", text: 4.5.to_s, count: 2
  end
end
