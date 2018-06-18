class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :profile

  def unbid
    self.profile.user.balance.unblock_amount(bid_value)
    self.auction.transactions.create(balance_id: self.profile.user.balance.id, amount: bid_value, transaction_type: 'bid_return')
  end

  def process
    self.profile.user.balance.withdraw_from_blocked(bid_value)
    if self.auction.is_charitable?
      self.auction.transactions.create(balance_id: self.auction.profile.user.balance.id, amount: bid_value, transaction_type: 'charity')
    else
      self.auction.profile.user.balance.add_amount(bid_value*0.8)
      self.auction.transactions.create(balance_id: self.auction.profile.user.balance.id, amount: bid_value*0.8, transaction_type: 'auction_reward')
      self.auction.transactions.create(balance_id: self.auction.profile.user.balance.id, amount: bid_value*0.2, transaction_type: 'service_fee')
    end
  end

end
