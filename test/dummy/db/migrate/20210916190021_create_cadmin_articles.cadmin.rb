# This migration comes from cadmin (originally 20210916185832)
class CreateCadminArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_articles do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: {to_table: :cadmin_users}

      t.timestamps
    end
  end
end
