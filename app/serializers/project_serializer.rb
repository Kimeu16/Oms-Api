class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :project_name, :description, :client_details, :client_id

  belongs_to :client
  has_many :tasks
end
