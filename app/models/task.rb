class Task < ApplicationRecord
  belongs_to :project, optional: true
  has_many :timesheets
  belongs_to :staff, optional: true
end
