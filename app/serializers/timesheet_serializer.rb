class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :progress_details, :task_detail, :task_id, :staff_id

  belongs_to :task, optional: true
  belongs_to :staff
end
