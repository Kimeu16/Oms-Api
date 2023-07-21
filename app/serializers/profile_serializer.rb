class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :bio, :avatar, :about, :location, :staff_id

  belongs_to :staff
end
