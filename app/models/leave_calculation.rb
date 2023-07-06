class LeaveCalculation < ApplicationRecord
  belongs_to :leave_type, optional: true
end
