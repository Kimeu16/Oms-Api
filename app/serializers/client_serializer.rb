class ClientSerializer < ActiveModel::Serializer
  attributes :id, :client_name, :description

  has_many :projects
end
