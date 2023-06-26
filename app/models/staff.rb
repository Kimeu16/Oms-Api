class Staff < ApplicationRecord
  has_secure_password

  belongs_to :admin
  has_one :form
  has_one :leave_type
  # has_many :timesheets, through: :tasks


  validates :staff_name, presence: true
  validates :joining_date, presence: true
  validates :reporting_to, presence: true
  validates :tech_stack, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
