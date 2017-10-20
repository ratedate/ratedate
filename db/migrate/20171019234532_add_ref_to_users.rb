class AddRefToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referred_by, :integer
    add_column :users, :eth_wallet, :string
  end
end
