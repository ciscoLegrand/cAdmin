class CreateCadminMainServices < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_main_services do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.string :slug
      t.timestamps
    end
    add_index :cadmin_main_services, :slug, unique: true
  end
end
