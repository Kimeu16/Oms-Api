class LeaveTypeSerializer < ActiveModel::Serializer
  attributes :id, :your_name, :days_allowed

  belongs_to :staff
end
