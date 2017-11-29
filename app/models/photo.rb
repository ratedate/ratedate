class Photo < ApplicationRecord
  belongs_to :profile
  mount_uploader :photo, PhotoUploader
end
