class Admin < ApplicationRecord
  has_secure_password

  has_many :staffs
  has_many :leave_forms, through: :staffs

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true
  # validates :password, presence: true, length: { minimum: 6 }
end
