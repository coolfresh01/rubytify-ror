class CreateGenreArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :genre_artists do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
