# This migration comes from cadmin (originally 20210930183605)
class CreateCadminTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_taggings do |t|
      t.references :tag, null: false, foreign_key: {to_table: :cadmin_tags}
      t.references :article, null: false, foreign_key: {to_table: :cadmin_articles }

      t.timestamps
    end
  end
end
