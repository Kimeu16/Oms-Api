class TaskSerializer < ActiveModel::Serializer
  attributes :id, :task_name, :assigned_to, :managed_by, :project_name, :avatar_image, :completed_files, :project_id, :staff_id

  belongs_to :project
  has_many :timesheets
  belongs_to :staff

end
