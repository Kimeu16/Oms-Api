class Staff < ApplicationRecord
  require "securerandom"
  has_secure_password

  belongs_to :admin, optional: true
  belongs_to :manager, optional: true
  has_many :forms
  has_many :leave_types
  has_many :leave_calculations, dependent: :destroy
  has_many :tasks
  has_many :projects, through: :tasks
  has_many :timesheets
  has_one :profile


  validates :staff_name, presence: true
  validates :joining_date, presence: true
  validates :reporting_to, presence: true
  validates :designation, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

end
