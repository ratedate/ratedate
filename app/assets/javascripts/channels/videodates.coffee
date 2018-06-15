
#= require 'simplewebrtc-with-adapter.bundle.js'

jQuery(document).on 'turbolinks:load', ->
#  first check if action cable subscription present
  user_dating = false
  App.cable.subscriptions.subscriptions.forEach (item) ->
    if JSON.parse(item["identifier"])["channel"]=="VideodatesChannel"
      user_dating = true
  if !user_dating
    App.dating = App.cable.subscriptions.create {
      channel: "VideodatesChannel"
    },
      connected: ->
# Called when the subscription is ready for use on the server
        auction = $('.video-page').data('auction')
        if auction
          App.dating.get_videodate_room(auction)

      disconnected: ->
# Called when the subscription has been terminated by the server

      received: (data) ->
        if data['videodate_room']
          connectVideodate(data['videodate_room'])
      get_videodate_room: (auction_id) ->
        @perform 'get_videodate_room', auction_id: auction_id
connectVideodate = (room) ->
  webrtc = new SimpleWebRTC({
    # the id/element dom element that will hold "our" video
      localVideoEl: 'localVideo',
    # the id/element dom element that will hold remote videos
      remoteVideosEl: 'remoteVideo',
    #immediately ask for camera access
      autoRequestMedia: true,
      url: 'https://ratedate.net:8888/'
      })
  webrtc.on 'readyToCall', () ->
    webrtc.joinRoom(room)