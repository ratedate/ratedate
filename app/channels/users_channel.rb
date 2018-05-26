# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from("users_#{current_user.id}_channel")
  end

  def unsubscribed
  end

  def video_date_invite (data)
    auction = Auction.find data['auction_id']
    if current_user.profile == auction.profile || current_user.profile == auction.winner
      participant = auction.video_date_participant(current_user.profile)
      conversation = Conversation.between(current_user.id, participant.id)[0]
      if conversation.nil?
        conversation = Conversation.create(author_id: current_user.id, receiver_id: participant.id)
      end
      ActionCable.server.broadcast "users_#{participant.id}_channel",
                                    video_date_invite: invitation(auction, current_user.profile, conversation)
      ActionCable.server.broadcast "users_#{current_user.id}_channel",
                                    video_date_page_ready: auction.id
    end
  end

  def redis
    Redis.new
  end

  def invitation(auction, profile, conversation)
    AuctionsController.render partial: 'auctions/invitation',
                              locals: {auction: auction, profile: profile, conversation: conversation}
  end
end