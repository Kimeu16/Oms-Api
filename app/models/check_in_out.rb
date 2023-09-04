class CheckInOut < ApplicationRecord
  belongs_to :staff, optional: true

  attribute :name, :string
  attribute :duration, :string

  # Calculate the duration based on timecheckedin and timecheckedout
  def calculate_duration
    if check_in.present? && check_out.present?
      # Calculate the duration in hours (assuming timecheckedin and timecheckedout are in DateTime format)
      hours_duration = ((check_out - check_in) / 1.hour).round(2)
      self.duration = "#{hours_duration} hours"
    else
      self.duration = nil
    end
  end

  # You might want to call this method after saving a record to update the duration
  after_save :calculate_duration
end

