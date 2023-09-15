class Manager < ApplicationRecord
  has_many :staffs

  validates :f_name, presence: true
  validates :l_name, presence: true
  validates :managers_title, presence: true
  validates :email, presence: true, uniqueness: true

end
