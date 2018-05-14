jQuery(document).on 'turbolinks:load', ->
#  first check if action cable subscription present
  showInviteDialog = (invite) ->
#TODO think about the ring sound
    $('body').append(invite)
  user_subscribed = false
  App.cable.subscriptions.subscriptions.forEach (item) ->
    if JSON.parse(item["identifier"])["channel"]=="UsersChannel"
      user_subscribed = true
  if !user_subscribed
    App.users = App.cable.subscriptions.create {
      channel: "UsersChannel"
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      if data['available_balance']
        $('.balance>span').text(data['available_balance'])
      if data['video_date_invite']
        showInviteDialog(data['video_date_invite'])
    video_date_invite: (auction_id) ->
      @perform 'video_date_invite', auction_id: auction_id

$(document).on 'click', '.button-invite', (e) ->
  App.users.video_date_invite($(this).data('auction'))
  Turbolinks.visit('/en/auctions/'+$(this).data('auction')+'/videodate')