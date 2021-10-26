class CreateCadminInterviews < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_interviews do |t|
      t.references :event, null: false, foreign_key:  {to_table: :cadmin_events}
      t.references :employee_id, null: false, foreign_key: true
      t.string :ceremony_music
      t.string :appetizer_music
      t.string :banquet_music
      t.string :ceremony_time
      t.string :entry
      t.string :bridal_dance
      t.boolean :garter
      t.string :garter_music
      t.boolean :figures
      t.string :figures_music
      t.text :gift_information
      t.text :observations

      t.timestamps
    end
  end
end