jQuery(document).on 'turbolinks:load', ->
#  first check if action cable subscription present
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