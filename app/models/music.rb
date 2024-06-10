class Music < ApplicationRecord
  belongs_to :artist

  validates :title, presence: true, length: { maximum: 255 }
  validates :album_name, presence: true, length: { maximum: 255 }

  validate :artist_exists

  enum genre: {rnb: 'Rhythm and Blues', country: 'Country', classic: 'Classic', rock: 'Rock', jazz: 'Jazz'}

  def artist_exists
    unless Artist.exists?(artist_id)
      errors.add(:error, 'Artist not found!')
    end
  end
end
