class CreateCadminEmailCustomTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_email_custom_templates do |t|
      t.text :content
      t.references :email_base_template, null: false, foreign_key: {to_table: :cadmin_email_base_templates}
      
      t.timestamps
    end
  end
end
