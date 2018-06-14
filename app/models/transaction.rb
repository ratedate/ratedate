class Transaction < ApplicationRecord
  belongs_to :balance
  belongs_to :transactionable, polymorphic: true
end
