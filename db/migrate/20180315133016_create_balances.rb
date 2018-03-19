class CreateBalances < ActiveRecord::Migration[5.1]
  def change
    create_table :balances do |t|
      t.integer :user_id
      t.decimal :balance, :default=> 0, :null=>false
      t.decimal :unavailable_balance, :default=> 0, :null=>false

      t.timestamps
    end
  end
end
