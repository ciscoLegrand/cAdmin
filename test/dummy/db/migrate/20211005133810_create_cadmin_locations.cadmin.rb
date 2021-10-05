# This migration comes from cadmin (originally 20211005131047)
class CreateCadminLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_locations do |t|
      t.string :name
      t.text :address
      t.integer :postal_code
      t.string :province
      t.text :coords

      t.timestamps
    end
  end
end
