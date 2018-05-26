class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :profile
  def unbid
    self.profile.user.balance.unblock_amount(bid_value)
  end

  def process
    self.profile.user.balance.withdraw_from_blocked(bid_value)
    self.auction.profile.user.balance.add(bid_value)
  end
end
