class ManagerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :title

  has_many :staffs
end
