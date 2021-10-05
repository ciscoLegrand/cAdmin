# This migration comes from cadmin (originally 20210930183551)
class CreateCadminTags < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
