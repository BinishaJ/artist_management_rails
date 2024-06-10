class User < ApplicationRecord
  enum gender: {m: 'male', f: 'female', o: 'others'}
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL }
  validates :password_digest, length: { maximum: 500 }
  validates :phone, presence: true, length: { maximum: 20 }
  validate :dob_check
  validates :address, presence: true, length: { maximum: 255 }

  private

  def dob_check
    if dob? && dob >= Date.today
      errors.add(:error, "Invalid date of birth!")
    end
  end
end
