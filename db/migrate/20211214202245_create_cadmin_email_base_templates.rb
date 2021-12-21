class CreateCadminEmailBaseTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_email_base_templates do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :kind, null: false
      
      t.timestamps
    end
  end
end
