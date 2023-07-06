class Project < ApplicationRecord
  belongs_to :client, optional: true
  has_many :tasks
end
