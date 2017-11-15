# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  window.jcropInitialized = undefined
  initializeJcrop = ->
    $('#img_preview').Jcrop({
      onSelect: setCoords,
      onChange: setCoords,
      aspectRatio: 1
    }, ->
      window.jcropInitialized = this
      console.log(jcropInitialized)
      return)
    return
  if $('#img_preview').attr('src')!='#'
    initializeJcrop()
  readURL = (input) ->
    console.log(input)
    if input.files and input.files[0]
      console.log('input')
      reader = new FileReader
      reader.onload = (e) ->
        $('#img_preview').attr 'src', e.target.result
        $('#img_preview').attr 'style', ''
        if jcropInitialized
          jcropInitialized.destroy()
          initializeJcrop()
        else
          initializeJcrop()
        return
      reader.readAsDataURL input.files[0]
    return
  $('#profile_avatar').change ->
    console.log('pa change')
    $('#img_preview').removeClass 'hidden'
    readURL this
    return
  setCoords = (c) ->
    return
  options = {types: ['(cities)']}
  input = document.getElementById('profile_address');
  autocomplete = new google.maps.places.Autocomplete(input, options);
  return
$(document).on('turbolinks:load', ready)