class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  mount_uploader :image,ImageUploader
  validates :body_image_present, presence: true

  def body_image_present
    body.presence || image.presence
  end
end
