# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class VideodatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from("videodates_#{current_user.id}_channel")
    redis.set("user_#{current_user.id}_dating_now", "1")
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_dating_now")
    redis.del("user_#{current_user.id}_video_connected")
    auction_id = redis.get("user_#{current_user.id}_active_videodate")
    start_time = redis.get("video_date_#{auction_id}_started")
    if start_time
      videodate_past_time = Time.current.to_i - Time.new(start_time).to_i
      redis.del("video_date_#{auction_id}_started")
      auction = Auction.find auction_id
      total_past_time = auction.videodate_past_time+videodate_past_time
      ended = total_past_time>auction.date_duration ? true : false
      auction.update(videodate_past_time: total_past_time, videodate_ended: ended, videodate_end_time: DateTime.current)
    end
  end

  def get_videodate_room(data)
    auction = Auction.find data['auction_id']
    if auction.profile == current_user.profile || auction.winner == current_user.profile
      room = redis.get("videodate_room_#{auction.id}")
      if room.nil?
        room = SecureRandom.uuid()
        redis.set("videodate_room_#{auction.id}", room)
      end
      ActionCable.server.broadcast "videodates_#{current_user.id}_channel", videodate_room: room
    end
  end

  def set_video_start(data)
    redis.set("user_#{current_user.id}_video_connected", "1") if redis.get("user_#{current_user.id}_video_connected").nil?
    auction = Auction.find data['auction_id']
    redis.set("video_date_#{auction.id}_started", Time.current) if redis.get("user_#{video_date_participant(current_user.profile).id}_video_connected")
    redis.set("user_#{current_user.id}_active_videodate", auction.id)
  end

  def redis
    Redis.new
  end

end