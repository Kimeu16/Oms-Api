# app/serializers/check_in_serializer.rb
class CheckInSerializer < ActiveModel::Serializer
  attributes :id, :check_in_at, :check_out_at, :duration_in_hours, :staff_id

  def duration_in_hours
    object.duration_in_hours
  end
end
