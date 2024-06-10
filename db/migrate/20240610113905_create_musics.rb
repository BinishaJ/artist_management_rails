class CreateMusics < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.integer :artist_id
      t.string :title
      t.string :album_name
      t.string :genre

      t.timestamps
    end
  end
end
