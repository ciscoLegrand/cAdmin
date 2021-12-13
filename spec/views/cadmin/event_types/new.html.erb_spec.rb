require 'rails_helper'

RSpec.describe "event_types/new", type: :view do
  before(:each) do
    assign(:event_type, EventType.new(
      name: "MyString",
      salary: 1.5,
      overtime_pay: 1.5,
      assemble: 1.5
    ))
  end

  it "renders new event_type form" do
    render

    assert_select "form[action=?][method=?]", event_types_path, "post" do

      assert_select "input[name=?]", "event_type[name]"

      assert_select "input[name=?]", "event_type[salary]"

      assert_select "input[name=?]", "event_type[overtime_pay]"

      assert_select "input[name=?]", "event_type[assemble]"
    end
  end
end
