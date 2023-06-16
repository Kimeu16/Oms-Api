class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :date, :start_time, :end_time, :progress_details

  belongs_to :task
end
