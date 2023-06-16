class LeaveTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :days_allowed

  belongs_to :staff
end
