class Admin < ApplicationRecord
  has_secure_password

  attribute :isadmin, :boolean, default: true
  has_many :staffs

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end