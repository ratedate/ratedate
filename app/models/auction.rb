class Auction < ApplicationRecord
  belongs_to :profile
  has_many :bids
  has_many :raters, through: :bids, source: :profile
end
