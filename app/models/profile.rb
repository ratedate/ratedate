class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :city
  # Used for user avatar image edit
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :city_name, :administrative_area_level_1, :administrative_area_level_2, :country, :country_code

  before_validation :set_city

  mount_uploader :avatar, AvatarUploader
  # acts_as_taggable
  acts_as_ordered_taggable_on :hobbies, :musics, :films, :books



  def set_city
    if self.city_name
      city = City.find_or_create_by(city: self.city_name, country: self.country, country_code: self.country_code, administrative_area_level_1: self.administrative_area_level_1, administrative_area_level_2: self.administrative_area_level_2)
      self.city_id = city.id
    end
  end
  def age
    now = Time.now.utc.to_date
    now.year - self.dob.year - ((now.month > self.dob.month || (now.month == self.dob.month && now.day >= self.dob.day)) ? 0 : 1)
  end
end
