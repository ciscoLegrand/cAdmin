class CreateCadminEventServices < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_event_services do |t|
      t.references :event, null: false, foreign_key: {to_table: :cadmin_events}
      t.references :service, null: false, foreign_key: {to_table: :cadmin_services}
      t.references :discount, null: false, default: 1, foreign_key: {to_table: :cadmin_discounts}
      t.integer :start_time
      t.integer :overtime, null:false, default: 0
      t.float :total_amount, null: false, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
