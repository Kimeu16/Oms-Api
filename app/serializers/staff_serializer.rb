class StaffSerializer < ActiveModel::Serializer
  attributes :id, :name, :joining_date, :reporting_to, :email, :password_digest, :tech_stack, :isStaff, :admin_id

  belongs_to :admin
  has_one :form
  has_one :leave_type
  # has_many :timesheets, through: :tasks

end
