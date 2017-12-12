jQuery(document).on 'turbolinks:load', ->
#  first check if action cable subscription present
  appearence_subscribed = false
  App.cable.subscriptions.subscriptions.forEach (item) ->
    if JSON.parse(item["identifier"])["channel"]=="AppearancesChannel"
      appearence_subscribed = true
  if !appearence_subscribed
    App.personal_chat = App.cable.subscriptions.create {
      channel: "AppearancesChannel"
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      user = $(".user-#{data['user_id']}")
      user.toggleClass 'online', data['online']