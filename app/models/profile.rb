class Profile < ApplicationRecord
  include Filterable

  belongs_to :user
  belongs_to :city
  has_many :photos
  # Used for user avatar image edit
  attr_accessor :city_name, :administrative_area_level_1, :administrative_area_level_2, :country, :country_code
  accepts_nested_attributes_for :photos, allow_destroy: true

  before_validation :set_city

  mount_uploader :avatar, AvatarUploader
  # acts_as_taggable
  acts_as_ordered_taggable_on :hobbies, :musics, :films, :books

  scope :by_country, -> (country) {where city_id: City.where(country: country) }
  scope :by_city, -> (city) {where city_id: city }
  scope :by_gender, -> (gender) {where gender: gender}
  scope :by_age_from, -> (age_from) {where 'dob <= ?', Date.today - age_from.to_i.year}
  scope :by_age_to, -> (age_to) {where 'dob >= ?', Date.today - age_to.to_i.year}
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
