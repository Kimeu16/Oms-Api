class EventSerializer < ActiveModel::Serializer
  attributes :id, :time,:agenda, :host, :trainer, :documents, :email, :meeting_link, :staff_id, :client_id, :manager_id
end
