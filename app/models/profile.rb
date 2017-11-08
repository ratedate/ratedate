class Profile < ApplicationRecord

  mount_uploader :avatar, AvatarUploader
end
