class Task < ApplicationRecord
  belongs_to :project
  belongs_to :staff

  has_many :timesheets
end
