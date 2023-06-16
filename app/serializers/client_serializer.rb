class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :projects
end
