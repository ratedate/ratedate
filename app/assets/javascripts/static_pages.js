//  Place all the behaviors and hooks related to the matching controller here.
//  All this logic will automatically be available in application.js.
//  You can use CoffeeScript in this file: http://coffeescript.org/
//
// jQuery ($) ->
//   $(window).scroll->
//     scrollPos = $(window).scrollTop
//     navbar = $('.navbar')
//     if (scrollPos>1000)->
//       navbar.addClass('navbar-light bg-light')
//       navbar.removeClass('navbar-dark bg-fade')
//     else->
//       navbar.removeClass('navbar-light bg-light')
//       navbar.addClass('navbar-dark bg-fade')


jQuery(document).ready(function($) {
  $(window).scroll(function() {
    var scrollPos = $(window).scrollTop(),
        navbar = $('.navbar');

    if (scrollPos > 60) {
      navbar.addClass('navbar-light bg-light')
      navbar.removeClass('navbar-dark bg-fade')
    } else {
      navbar.removeClass('navbar-light bg-light')
      navbar.addClass('navbar-dark bg-fade')
    }
  });

});