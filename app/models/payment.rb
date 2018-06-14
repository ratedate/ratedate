class Payment < ApplicationRecord
  belongs_to :user
  has_many :transactions, :as => :transactionable

  attr_accessor :response_status, :response_signature_string

  def complete
    if self.user.balance.nil?
      self.user.create_balance()
    end
    self.user.balance.add_amount(rdt_amount)
    self.transactions.create(balance_id: user.balance.id, amount: rdt_amount, transaction_type: 'payment')
  end
end
