# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class VideodatesChannel < ApplicationCable::Channel
  def subscribed
    stream_from("videodates_#{current_user.id}_channel")
    redis.set("user_#{current_user.id}_dating_now", "1")
  end

  def unsubscribed
    redis.del("user_#{current_user.id}_dating_now")
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

  def redis
    Redis.new
  end

end