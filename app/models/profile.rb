class Profile < ApplicationRecord
  belongs_to :user
  # Used for user avatar image edit
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  mount_uploader :avatar, AvatarUploader
  # acts_as_taggable
  acts_as_ordered_taggable_on :hobbies, :musics, :films, :books
end
