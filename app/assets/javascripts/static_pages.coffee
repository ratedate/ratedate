# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_nav_background = ->
  navbar = $('.navbar')
  scrollPos = $(window).scrollTop()
  if scrollPos>60
    navbar.addClass('navbar-light bg-light')
    navbar.removeClass('navbar-dark bg-fade')
    return
  else
    navbar.removeClass('navbar-light bg-light')
    navbar.addClass('navbar-dark bg-fade')
    return
ready = ->
  set_nav_background()
  $(window).scroll ->
    set_nav_background()
    return
  $('.nav-link').click ->
    $a = $($(this).attr('href'))
    $('.navbar-collapse').collapse('hide')
    $('html,body').animate({ scrollTop: $a.offset().top - 101}, 500)
    false
  $('.navbar-toggler').click ->
    navbar = $('.navbar')
    navbar.addClass('navbar-light bg-light')
    navbar.removeClass('navbar-dark bg-fade')
    return
  return
$(document).ready(ready)
$(document).on('turbolinks:load', ready)

