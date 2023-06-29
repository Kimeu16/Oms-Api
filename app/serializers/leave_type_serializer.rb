class LeaveTypeSerializer < ActiveModel::Serializer
  attributes :id, :your_name, :days_allowed, :staff_id

  belongs_to :staff
end
