class CheckIn < ApplicationRecord
  belongs_to :staff

  validates :check_in_at, presence: true

  def duration_in_hours
    return nil unless check_out_at.present?

    duration = (check_out_at - check_in_at) / 3600 # Convert seconds to hours
    duration.round(2) # Round to 2 decimal places
  end
end
