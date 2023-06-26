class TaskSerializer < ActiveModel::Serializer
  attributes :id, :task_name, :assigned_to, :managed_by, :project_id

  belongs_to :project
  has_many :timesheets
end
