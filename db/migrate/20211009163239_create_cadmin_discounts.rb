class CreateCadminDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_discounts do |t|
      t.string :name
      t.string :type_discount
      t.text :description
      t.float :percentage
      t.float :amount
      t.date :start_date
      t.date :end_date
      t.text :observations
      t.references :event, null: true, foreign_key: {to_table: :cadmin_events}
      t.references :service, null: true, foreign_key: {to_table: :cadmin_services}
      
      t.timestamps
    end
  end
end
