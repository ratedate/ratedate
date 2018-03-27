json.extract! auction, :id, :aim, :rater_age_min, :rater_age_max, :rater_gender, :date_duration, :auction_end, :video_date_start, :bid_step, :start_bid, :video_preview, :created_at, :updated_at
json.url auction_url(auction, format: :json)
