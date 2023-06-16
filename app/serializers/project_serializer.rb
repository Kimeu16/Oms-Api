class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :client_name, :description, :action

  belongs_to :client
  has_many :tasks
end
