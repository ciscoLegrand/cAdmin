class CreateCadminEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_events do |t|
      t.integer :customer_id, null: false 
      t.integer :employee_id, null: true
      t.string :type_name, null: false, default: 'wedding'
      t.string :number, null: false 
      t.date :date, null: false
      t.integer :guests
      t.integer :start_time
      t.integer :extra_hours, null: false, default: 0
      t.text :service_ids
      t.integer :place_id
      t.float :deposit, null: false, default: 0
      t.float :total_amount, null: false, default: 0
      t.boolean :charged, null: false, default: false
      t.text :observations   

      t.timestamps
    end
  end
end
