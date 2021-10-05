# This migration comes from cadmin (originally 20211005131359)
class CreateCadminServices < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_services do |t|
      t.string :name
      t.text :short_dscription
      t.text :description
      t.string :metatitle
      t.text :metadescription
      t.text :features
      t.float :price
      t.float :hour_price
      t.float :extra_hour
      t.integer :initial_hours

      t.timestamps
    end
  end
end
