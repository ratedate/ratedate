class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.integer :auction_id
      t.integer :profile_id
      t.decimal :bid_value

      t.timestamps
    end
  end
end
