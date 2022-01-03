class CreateCadminCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_carts do |t|
      t.string :ip
      t.string :status

      t.timestamps
    end
  end
end
