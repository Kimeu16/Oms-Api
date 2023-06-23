class FormSerializer < ActiveModel::Serializer
  attributes :id, :date_from, :date_to, :reason_for_leave, :leave_type, :staff_id

  belongs_to :staff
end
