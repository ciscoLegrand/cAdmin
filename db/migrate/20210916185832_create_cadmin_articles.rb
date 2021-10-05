class CreateCadminArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :status, null: false, default: 0
      t.date :published_at, null: false, default: Time.now
      t.date :unpublished_at
      t.string :metatitle
      t.string :metadata
      t.text :image_data
      t.references :user, null: false, foreign_key: {to_table: :cadmin_users}
      t.references :article_category, null: false, foreign_key: {to_table: :cadmin_article_categories}

      t.timestamps
    end
  end
end
