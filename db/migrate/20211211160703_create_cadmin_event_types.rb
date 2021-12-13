class CreateCadminEventTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_event_types do |t|
      t.string :name
      t.float :salary, null: false, default: 0, precision: 10, scale: 2
      t.float :overtime_price, null: false, default: 0, precision: 10, scale: 2
      t.float :assemble, null: false, default: 0, precision: 10, scale: 2

      t.timestamps
    end
  end
end
