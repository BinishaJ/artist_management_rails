class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.date :dob
      t.string :gender
      t.string :address
      t.integer :first_release_year
      t.integer :no_of_albums_released

      t.timestamps
    end
  end
end
