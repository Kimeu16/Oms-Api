class LeaveFormSerializer < ActiveModel::Serializer
  attributes :id, :date_from, :date_to, :reason_for_leave, :leave_type

  belongs_to :staff
end
