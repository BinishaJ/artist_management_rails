class User < ApplicationRecord
  # include GenderEnum
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  enum gender: {m: 'male', f: 'female', o: 'others'}, _prefix: true

  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL }
  validates :password_digest, length: { maximum: 500 }
  validates :phone, length: { maximum: 20 }
  validates :address, length: { maximum: 255 }

  validate :email_check
  validate :dob_check

  private

  def dob_check
    if dob? && dob >= Date.today
      errors.add(:error, "Invalid date of birth!")
    end
  end

  def email_check
    if User.exists?(email: email.downcase)
      errors.add(:error, "Email has already been taken!")
    end
  end

end
