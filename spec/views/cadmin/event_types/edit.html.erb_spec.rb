require 'rails_helper'

RSpec.describe "event_types/edit", type: :view do
  before(:each) do
    @event_type = assign(:event_type, EventType.create!(
      name: "MyString",
      salary: 1.5,
      overtime_pay: 1.5,
      assemble: 1.5
    ))
  end

  it "renders the edit event_type form" do
    render

    assert_select "form[action=?][method=?]", event_type_path(@event_type), "post" do

      assert_select "input[name=?]", "event_type[name]"

      assert_select "input[name=?]", "event_type[salary]"

      assert_select "input[name=?]", "event_type[overtime_pay]"

      assert_select "input[name=?]", "event_type[assemble]"
    end
  end
end
