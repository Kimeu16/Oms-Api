class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :project_name, :client_name, :description, :client_id

  belongs_to :client
  has_many :tasks
end
