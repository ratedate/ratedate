class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.string :order_id
      t.string :order_desc
      t.integer :amount
      t.string :currency
      t.string :order_status
      t.string :signature
      t.string :tran_type
      t.decimal :rdt_amount

      t.timestamps
    end
  end
end
