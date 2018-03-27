jQuery(document).on 'turbolinks:load', ->
#  first check if action cable subscription present
  auction_subscribed = false
  App.cable.subscriptions.subscriptions.forEach (item) ->
    if JSON.parse(item["identifier"])["channel"]=="AuctionsChannel"
      auction_subscribed = true
  if !auction_subscribed
    App.auction = App.cable.subscriptions.create {
      channel: "AuctionsChannel"
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data['auction_id']
        auction = $('#auction_'+data['auction_id'])
        if auction
          auction.find('.bid-value>span').text(data['bid'])
          auction.find('input').val(data['min_bid'])
          $('.bid-title').text('Highest bid')
    place_bid: (auction_id, bid) ->
      @perform 'place_bid', auction_id: auction_id, bid: bid
$(document).on 'click', '.button-bid', (e) ->
  if Number($('.balance>span').text()) >= Number($(this).prev('input').val())
    App.auction.place_bid($(this).data('auction'), $('#auction_bid_'+$(this).data('auction')).val())
  else
   $('#buy-rdt-modal').addClass('show')