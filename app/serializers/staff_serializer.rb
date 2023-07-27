class StaffSerializer < ActiveModel::Serializer
  attributes :id, :staff_name, :joining_date, :reporting_to, :email, :password_digest, :tech_stack, :isStaff, :admin_id, :manager_id

  belongs_to :admin
  belongs_to :manager
  has_many :forms
  has_many :leave_calculations, dependent: :destroy
  has_many :leave_types
  has_many :tasks
  has_many :projects, through: :tasks
  has_many :timesheets, through: :tasks
  has_one :profile

end
