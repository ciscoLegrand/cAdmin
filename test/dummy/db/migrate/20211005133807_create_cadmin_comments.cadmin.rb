# This migration comes from cadmin (originally 20210917053524)
class CreateCadminComments < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: {to_table: :cadmin_users }
      t.references :article, null: false, foreign_key: {to_table: :cadmin_articles}

      t.timestamps
    end
  end
end
