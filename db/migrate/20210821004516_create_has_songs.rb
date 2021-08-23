class CreateHasSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :has_songs do |t|
      t.references :album, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
