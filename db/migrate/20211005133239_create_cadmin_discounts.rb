class CreateCadminDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_discounts do |t|
      t.string :name
      t.string :type_discount
      t.text :description
      t.float :percentage, precision: 10, scale: 2
      t.float :amount, precision: 10, scale: 2
      t.date :start_date
      t.date :end_date
      t.text :observations
      t.string :slug 
      t.timestamps
    end
    add_index :cadmin_discounts, :slug, unique: true
  end
end
