class Staff < ApplicationRecord
  has_secure_password

  has_many :leave_forms
  # has_one :leave_type
  # has_many :tasks
  belongs_to :admin

  validates :name, presence: true
  validates :joining_date, presence: true
  validates :reporting_to, presence: true
  validates :tech_stack, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
