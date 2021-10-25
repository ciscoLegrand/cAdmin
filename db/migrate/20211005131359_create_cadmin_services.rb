class CreateCadminServices < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_services do |t|
      t.string :name
      t.float :price
      t.float :hour_price, null: false, default: 0
      t.text :short_dscription
      t.text :description
      t.text :features
      t.integer :stock
      t.string :metatitle
      t.text :metadescription
      t.text :image_data
      t.references :main_service, null: false, foreign_key: {to_table: :cadmin_main_services}

      t.timestamps
    end
  end
end
