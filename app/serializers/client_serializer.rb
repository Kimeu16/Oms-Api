class ClientSerializer < ActiveModel::Serializer
  attributes :id, :client_name, :description, :first_email, :second_email, :first_contact, :second_contact

  has_many :projects
end
