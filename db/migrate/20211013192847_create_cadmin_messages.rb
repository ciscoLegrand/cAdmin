class CreateCadminMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_messages do |t|
      t.text :body
      t.boolean :viewed, default: false
      t.references :conversation, null: false, foreign_key: {to_table: :cadmin_conversations}
      t.references :user, null: false, foreign_key: {to_table: :cadmin_users}
      t.timestamps
    end
  end
end
