# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).on 'turbolinks:load', ->
  messages = $('#conversation-body')
  #  first check if action cable subscription present
  pm_subscribed = false
  messages_to_bottom = ->
    messages_wrap = $('#conversation-main')
    messages_wrap.scrollTop(messages_wrap.prop("scrollHeight"))
    return
  App.cable.subscriptions.subscriptions.forEach (item) ->
    if JSON.parse(item["identifier"])["channel"]=="NotificationsChannel"
      pm_subscribed = true
  if $('#signed-user').length > 0 && !pm_subscribed
    App.personal_chat = App.cable.subscriptions.create {
      channel: "NotificationsChannel"
    },
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      messages = $('#conversation-body')
      if messages.length > 0 && messages.data('conversation-id') is data['conversation_id']
        messages.append data['message']
        $('#conversation-'+data['conversation_id']+' em').text(data['truncated_message'])
        messages_to_bottom()
        $.getScript('/conversations/'+data['conversation_id']) if $('#conversations').length > 0
      else
        $.getScript('/conversations') if $('#conversations').length > 0
        $('body').append(data['notification']) if data['notification']

    send_message: (message, conversation_id) ->
      @perform 'send_message', message: message, conversation_id: conversation_id

  $(document).on 'click', '#notification .close', ->
    $(this).parents('#notification').fadeOut(1000)

  if messages.length > 0
    messages_to_bottom()
    $('#new_personal_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#personal_message_body')
      if $.trim(textarea.val()).length > 0
        App.personal_chat.send_message textarea.val(), $this.find('#conversation_id').val()
        textarea.val('')
      e.preventDefault()
      return false
    return