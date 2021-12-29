class CreateCadminTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :cadmin_tracks do |t|
      t.string :name
      t.string :artist
      t.string :image
      t.string :preview
      t.string :spotify_id
      t.string :slug
      t.timestamps
    end
    add_index :cadmin_tracks, :slug, unique: true
  end
end
