class CreateCadminEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_events do |t|
      t.string :name, null: false 
      t.string :type_name, null: false, default: 'wedding'
      t.string :number, null: false 
      t.date :date, null: false
      t.string :location
      t.integer :guests
      t.integer :start_time
      t.integer :extra_hours
      t.references :user, null: false, foreign_key: {to_table: :cadmin_users}
      t.references :service, null: true, foreign_key: {to_table: :cadmin_services}
      t.references :place, null:true, foreign_key: {to_table: :cadmin_locations}
      t.float :deposit
      t.float :total_amount
      t.boolean :charged, null: false, default: false
      t.text :observations

      t.timestamps
    end
  end
end
