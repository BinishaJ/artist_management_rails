class Artist < ApplicationRecord
  # include GenderEnum
  has_many :music

  validates :name, presence: true, length: { maximum: 255 }
  validates :address, presence: true, length: { maximum: 255 }

  validate :dob_check
  validate :release_year_check
  validate :albums_released_check


  enum gender: {m: 'male', f: 'female', o: 'others'}, _prefix: true

  private
  def dob_check
    if dob? && dob >= Date.today
      errors.add(:error, "Invalid date of birth!")
    end
  end

  def release_year_check
    if first_release_year? && first_release_year >= Date.today.year
      errors.add(:error, "Invalid release year!")
    end
  end

  def albums_released_check
    if no_of_albums_released? && no_of_albums_released < 0
      errors.add(:error, "Invalid number of albums!")
    end
  end

end
