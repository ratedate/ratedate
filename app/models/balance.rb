class Balance < ApplicationRecord
  belongs_to :user
  after_commit :broadcast_balance
  def block_amount(amount)
    self.unavailable_balance += amount.to_d
    self.save!
  end
  def unblock_amount(amount)
    self.unavailable_balance -= amount.to_d
    self.save!
  end
  def available_balance
    balance-unavailable_balance
  end

  def broadcast_balance
    UserBroadcastJob.perform_later(self)
  end
end
