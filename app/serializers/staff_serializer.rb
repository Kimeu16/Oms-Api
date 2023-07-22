class StaffSerializer < ActiveModel::Serializer
  attributes :id, :staff_name, :joining_date, :reporting_to, :email

  belongs_to :admin
  belongs_to :manager
  has_one :form
  has_one :leave_type
  has_many :tasks, dependent: :destroy
  has_many :projects, through: :tasks
  has_many :timesheets, through: :tasks

end
