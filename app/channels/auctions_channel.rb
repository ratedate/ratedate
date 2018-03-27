# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class AuctionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from("auctions_channel")
  end

  def unsubscribed
  end

  def place_bid(data)
    auction = Auction.find_by(id: data['auction_id'])
    if current_user.balance.present?
      if auction && auction.profile != current_user.profile && data['bid'].to_d <= current_user.balance.available_balance
        current_user.balance.block_amount(data['bid'])
        auction.bids.last.unbid if auction.bids.any?
        bid = auction.bids.build(profile_id: current_user.profile.id, bid_value: data['bid'])
        if bid.save!
          ActionCable.server.broadcast 'auctions_channel',
                                        auction_id: auction.id,
                                        bid: "%g"%bid.bid_value,
                                        min_bid: "%g"%(bid.bid_value+auction.bid_step)
        else
          current_user.balance.unblock_amount(data['bid'])
        end
      end
    end
  end
end