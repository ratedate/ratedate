class Auction < ApplicationRecord
  include Filterable
  attr_accessor :timezone
  belongs_to :profile
  has_many :bids
  has_many :raters, through: :bids, source: :profile
  belongs_to :winner, class_name: 'Profile', optional: true
  has_many :transactions, :as => :transactionable

  before_save :set_time_in_timezone

  scope :by_country, -> (country) {where 'profiles.city_id IN (?)', City.where(country: country).select('id') }
  scope :by_city, -> (city) {where city_id: city }
  scope :by_gender, -> (gender) {where 'profiles.gender = ?', gender}
  scope :by_age_from, -> (age_from) {where 'profiles.dob <= ?', Date.today - age_from.to_i.year}
  scope :by_age_to, -> (age_to) {where 'profiles.dob >= ?', Date.today - age_to.to_i.year}
  scope :active, -> {where('auction_end>?', DateTime.current)}
  scope :ended, -> {where('auction_end<=?', DateTime.current)}
  scope :videodate_not_ended, -> {where('videodate_ended = ?',false)}

  def video_date_participant(prof)
    prof==profile ?  winner.user : profile.user
  end

  def winner_bid
    self.bids.max_by{|x| x.bid_value}
  end

  def finish_video_date
    if auction_end < DateTime.current
      # TODO add finished to auction with date
      self.winner_bid.process
    end
  end

  def is_charitable?
    self.charitable
  end

  def set_time_in_timezone
    if self.timezone
      self.auction_end = self.auction_end.asctime.in_time_zone(self.timezone).utc
    end
  end
end
