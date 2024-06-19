class User < ApplicationRecord
  # include GenderEnum

  belongs_to :role

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_secure_password

  enum gender: {m: 'male', f: 'female', o: 'others'}, _prefix: true

  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL }, uniqueness: { case_sensitive: false }
  validates :password_digest, length: { maximum: 500 }
  validates :phone, length: { maximum: 20 }
  validates :address, length: { maximum: 255 }

  validate :dob_check
  # validate :email_check

  private

  def dob_check
    p "D #{Date.today}"
    if dob? && dob >= Date.today
      errors.add(:error, "Invalid date of birth!")
    end
  end

  # def email_check
  #   if email? && User.exists?(email: email.downcase)
  #     errors.add(:error, "Email has already been taken!")
  #   end
  # end

end
