#= require 'ekko-lightbox'


$(document).on 'click', '[data-toggle="lightbox"]', (event) ->
  event.preventDefault();
  $(this).ekkoLightbox();