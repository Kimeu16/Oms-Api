# app/serializers/check_in_out_serializer.rb
class CheckInOutSerializer < ActiveModel::Serializer
  attributes :id, :staff_id, :name, :check_in, :check_out, :formatted_created_at

  def formatted_created_at
    object.created_at.localtime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
