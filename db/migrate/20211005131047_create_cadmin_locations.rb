class CreateCadminLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_locations do |t|
      t.string :name
      t.text :address
      t.integer :postal_code
      t.string :province
      t.text :coords
      t.string :slug

      t.timestamps
    end
    add_index :cadmin_locations, :slug, unique: true
  end
end
