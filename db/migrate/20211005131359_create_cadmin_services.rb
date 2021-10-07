class CreateCadminServices < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_services do |t|
      t.string :name
      t.float :price
      t.float :hour_price
      t.text :short_dscription
      t.text :description
      t.text :features
      t.integer :stock
      t.string :metatitle
      t.text :metadescription

      t.timestamps
    end
  end
end
