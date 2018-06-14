class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :balance, foreign_key: true
      t.decimal :amount
      t.string :transaction_type
      t.references :transactionable, polymorphic: true, index: {:name=>'index_transactions_on_type_and_id' }

      t.timestamps
    end
  end
end
