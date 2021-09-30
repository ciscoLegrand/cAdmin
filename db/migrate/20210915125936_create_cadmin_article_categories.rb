class CreateCadminArticleCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_article_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
