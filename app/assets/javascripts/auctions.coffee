#= require 'jquery.countdown'

$(document).on 'turbolinks:load', ->
  $('[data-countdown]').each ->
    $this = $(this)
    finalDate = new Date($(this).data('countdown'))
    $this.countdown finalDate, (event) ->
      $this.html(event.strftime('%D days %H:%M:%S'))
      progress = ((new Date).getTime()-$this.data('start'))*100/($this.data('countdown')-$this.data('start'))
      $this.parent('.auction-info-timer').find('.auction-info-timer-progress-bar').css({'width':progress+'%'})