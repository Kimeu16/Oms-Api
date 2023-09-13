class Event < ApplicationRecord

  belongs_to :staff, optional: true
  belongs_to :manager, optional: true
  belongs_to :client, optional: true
  # has_many_attached :documents

  validate :validate_documents_format

  mount_uploader :documents, AvatarUploader # Use mount_uploaders instead of mount_uploader
#   serialize :documents, JSON

  private

  def validate_documents_format
      return unless documents.present?
      errors.add(:documents, "Invalid file format") unless documents.file.extension.in?(%w(jpg jpeg png pdf docx txt mp4 avi mov))
  end

end
