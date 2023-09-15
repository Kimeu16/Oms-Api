class ManagerSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :managers_title, :email

  has_many :staffs
end
