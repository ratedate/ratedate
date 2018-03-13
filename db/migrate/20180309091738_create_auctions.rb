class CreateAuctions < ActiveRecord::Migration[5.1]
  def change
    create_table :auctions do |t|
      t.integer :profile_id
      t.string :aim
      t.integer :rater_age_min
      t.integer :rater_age_max
      t.string :rater_gender
      t.integer :date_duration
      t.datetime :auction_end
      t.datetime :video_date_start
      t.decimal :bid_step
      t.decimal :start_bid
      t.string :video_preview

      t.timestamps
    end
  end
end
