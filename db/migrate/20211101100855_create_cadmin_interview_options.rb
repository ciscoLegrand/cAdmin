class CreateCadminInterviewOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_interview_options do |t|
      t.string :gift
      t.string :song
      
      t.references :interview, null: false, foreign_key: {to_table: :cadmin_interviews}

      t.timestamps
    end
  end
end
