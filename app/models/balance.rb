class Balance < ApplicationRecord
  belongs_to :user
  after_commit :broadcast_balance

  # TODO add more logic to balance functions
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
  def add_amount(amount)
    self.balance += amount.to_d
    self.save!
  end

  def withdraw_from_blocked(amount)
    self.unavailable_balance -= amount.to_d
    self.balance -= amount.to_d
    self.save!
  end

  def withdraw_from_balance(amount)
    self.balance -= amount.to_d
  end

  def broadcast_balance
    UserBroadcastJob.perform_later(self)
  end
end
