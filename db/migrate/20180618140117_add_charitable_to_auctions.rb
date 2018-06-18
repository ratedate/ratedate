class AddCharitableToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :charitable, :boolean, :default => false
  end
end
