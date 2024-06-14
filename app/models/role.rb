class Role < ApplicationRecord

  validates :role, presence: true

  has_many :users

end
