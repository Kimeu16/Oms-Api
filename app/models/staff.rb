class Staff < ApplicationRecord
  has_one :leave_form
    has_one :leave_type
    has_many :tasks
end
