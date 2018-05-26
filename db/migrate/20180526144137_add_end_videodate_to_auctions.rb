class AddEndVideodateToAuctions < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :videodate_ended, :boolean, default: false
    add_column :auctions, :videodate_end_time, :datetime
    add_column :auctions, :videodate_past_time, :integer, default: 0
  end
end
