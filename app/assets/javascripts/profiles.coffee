# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  window.jcropInitialized = undefined
  initializeJcrop = ->
    w = Math.min($('#img_preview')[0].width,$('#img_preview')[0].height)
    $('#img_preview').Jcrop({
      onSelect: setCoords,
      onChange: setCoords,
      setSelect: [0,0,w,w],
      aspectRatio: 1
    }, ->
      window.jcropInitialized = this
      return)
    return
  setCoords = (c) ->
    console.log('setCoords')
    #    get width of scaled jcrop and divide to natural image width to obtain scale
    scale = $('#img_preview')[0].width/$('.jcrop-holder').width()
    $('#crop_x').val(Math.round(c.x*scale))
    $('#crop_y').val(Math.round(c.y*scale))
    $('#crop_w').val(Math.round(c.w*scale))
    $('#crop_h').val(Math.round(c.h*scale))
    return
  if $('#img_preview').attr('src')!='#'
    $('#img_preview').on 'load', (e) ->
      initializeJcrop()
      return
  readURL = (input) ->
    console.log(input)
    if input.files and input.files[0]
      console.log('input')
      reader = new FileReader
      reader.onload = (e) ->
        $('#img_preview').attr 'src', e.target.result
        $('#img_preview').attr 'style', ''
        return
      reader.onloadend = (e) ->
        if jcropInitialized
          jcropInitialized.destroy()
          initializeJcrop()
        else
          initializeJcrop()
      reader.readAsDataURL input.files[0]
    return
  $('#profile_avatar').change ->
    $('#img_preview').removeClass 'hidden'
    readURL this
    return
  options = {types: ['(cities)']}
  input = document.getElementById('profile_address');
  autocomplete = new google.maps.places.Autocomplete(input, options);
  return
$(document).on('turbolinks:load', ready)