class CreateCadminEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_events do |t|
      t.references :customer, null: false, foreign_key: {to_table: :cadmin_users}
      t.references :employee, null: true, foreign_key: {to_table: :cadmin_users}
      t.string :number, null: false, unique: true
      t.float :deposit, null: false, default: 0, precision: 10, scale: 2
      t.float :total_amount, null: false, default: 0, precision: 10, scale: 2
      t.references :cart, null: true, foreign_key: {to_table: :cadmin_carts}
      t.string :title
      t.string :status, null: false, default: 'pending'
      t.references :event_type, null: false, foreign_key: {to_table: :cadmin_event_types}
      t.date :date, null: false
      t.integer :guests 
      t.references :place, null: true, foreign_key: {to_table: :cadmin_locations}
      t.boolean :charged, null: false, default: false
      t.boolean :employee_paid, null: false, default: false
      t.text :observations
      t.string :slug 

      t.timestamps
    end
    add_index :cadmin_events, :slug, unique: true
  end
end
