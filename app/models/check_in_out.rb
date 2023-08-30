class CheckInOut < ApplicationRecord
  belongs_to :staff, optional: true

  attribute :name, :string
end

