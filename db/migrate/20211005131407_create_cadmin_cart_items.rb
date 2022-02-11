class CreateCadminCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_cart_items do |t|
      t.references :service, null: false, foreign_key: {to_table: :cadmin_services}
      t.references :cart, null: false, foreign_key: {to_table: :cadmin_carts}

      t.timestamps
    end
  end
end
