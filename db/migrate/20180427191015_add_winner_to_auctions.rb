class AddWinnerToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :winner_id, :integer
  end
end
