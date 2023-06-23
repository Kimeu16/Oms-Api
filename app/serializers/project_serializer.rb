class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :client_name, :description, :client_id

  belongs_to :client
  has_many :tasks
end
