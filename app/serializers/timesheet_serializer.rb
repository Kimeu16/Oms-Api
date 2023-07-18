class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :progress_details, :task_id, :staff_id

  belongs_to :task
  belongs_to :staff
end
