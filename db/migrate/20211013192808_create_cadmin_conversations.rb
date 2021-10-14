class CreateCadminConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_conversations do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :title

      t.timestamps
    end
  end
end
