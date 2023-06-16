class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :assigned_to, :managed_by

  belongs_to :project
  has_many :timesheets
end
