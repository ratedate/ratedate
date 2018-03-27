class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :profile
  def unbid
    self.profile.user.balance.unblock_amount(bid_value)
  end
end
