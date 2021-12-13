require 'rails_helper'

module Cadmin
  RSpec.describe EventType, type: :model do
    # pending "add some examples to (or delete) #{__FILE__}"
    it "Is a valid EventType" do
      ac = EventType.create(name: 'boda', salary: 160.00, overtime_price: 40.00,assemble: 0.00)
      expect(ac.valid?).to eq(true)
      puts "its #{expect(true).to eq(true)} -> EventType: #{ac.name}"
    end
  end
end
