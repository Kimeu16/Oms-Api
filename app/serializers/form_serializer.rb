class FormSerializer < ActiveModel::Serializer
  attributes :id, :your_name, :date_from, :date_to, :reason_for_leave, :leaving_type, :staff_id

  belongs_to :staff
end
