class Auction < ApplicationRecord
  include Filterable

  belongs_to :profile
  has_many :bids
  has_many :raters, through: :bids, source: :profile

  scope :by_country, -> (country) {where 'profiles.city_id IN (?)', City.where(country: country).select('id') }
  scope :by_city, -> (city) {where city_id: city }
  scope :by_gender, -> (gender) {where 'profiles.gender = ?', gender}
  scope :by_age_from, -> (age_from) {where 'profiles.dob <= ?', Date.today - age_from.to_i.year}
  scope :by_age_to, -> (age_to) {where 'profiles.dob >= ?', Date.today - age_to.to_i.year}
  scope :active, -> {where('auction_end>?', DateTime.now)}
  scope :ended, -> {where('auction_end<=?', DateTime.now)}
end
