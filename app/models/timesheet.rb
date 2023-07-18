class Timesheet < ApplicationRecord
  belongs_to :task
  belongs_to :staff
end
