class CreateCadminEmailBaseTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_email_base_templates do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :kind, null: false
      t.string :slug
      t.timestamps
    end
    add_index :cadmin_email_base_templates, :slug, unique: true
  end
end
