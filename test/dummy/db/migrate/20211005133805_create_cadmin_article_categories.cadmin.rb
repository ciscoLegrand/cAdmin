# This migration comes from cadmin (originally 20210915125936)
class CreateCadminArticleCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_article_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
