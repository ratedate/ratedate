# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class AuctionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from("auctions_channel")
  end

  def unsubscribed
  end

  def place_bid(data)
    auction = Auction.find_by(id: data['auction_id'])
    # TODO move verification to bids model
    if current_user.balance.present?
      if auction && auction.profile != current_user.profile && data['bid'].to_d <= current_user.balance.available_balance && current_user.profile.id!=auction.winner_id
        current_user.balance.block_amount(data['bid'])
        if auction.bids.any?
          if data['bid'].to_d>auction.winner_bid.bid_value
            auction.winner_bid.unbid
            bid = auction.bids.build(profile_id: current_user.profile.id, bid_value: data['bid'])
            if bid.save!
              auction.update(winner_id: current_user.profile.id)
              auction.transactions.create(balance_id: current_user.balance.id, amount: bid.bid_value, transaction_type: 'place_bid')
              ActionCable.server.broadcast 'auctions_channel',
                                           auction_id: auction.id,
                                           bid: "%g"%bid.bid_value,
                                           min_bid: "%g"%(bid.bid_value+auction.bid_step)
            else
              current_user.balance.unblock_amount(data['bid'])
            end
          end
        else
          if data['bid'].to_d >= auction.start_bid
            bid = auction.bids.build(profile_id: current_user.profile.id, bid_value: data['bid'])
            if bid.save!
              auction.update(winner_id: current_user.profile.id)
              auction.transactions.create(balance_id: current_user.balance.id, amount: bid.bid_value, transaction_type: 'place_bid')
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
  end
end