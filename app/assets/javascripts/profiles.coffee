# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  $('#hobby_list').tagsinput({tagClass: 'badge-secondary'})
  $('#film_list').tagsinput({tagClass: 'badge-secondary'})
  $('#music_list').tagsinput({tagClass: 'badge-secondary'})
  $('#book_list').tagsinput({tagClass: 'badge-secondary'})
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
    if input.files and input.files[0]
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
  $('[id$="photo"]').change ->
    input = this
    if input.files and input.files[0]
      photo_reader = new FileReader
      photo_reader.onload = (e) ->
        input.previousElementSibling.src = e.target.result
        return
      photo_reader.readAsDataURL input.files[0]
      return
  options = {types: ['(cities)']}
  input = document.getElementById('profile_address');
  window.autocomplete = new google.maps.places.Autocomplete(input, options);
  fillInAddress = ->
    place = autocomplete.getPlace()
    i = 0
    state = ''
    document.getElementById('administrative_area_level_1').value = ''
    document.getElementById('administrative_area_level_2').value = ''
    while i<place.address_components.length
      addressType = place.address_components[i].types[0]
      if addressType == "locality"
        document.getElementById('profile_city').value = place.address_components[i]['long_name']
      if addressType == "administrative_area_level_1" || addressType == "administrative_area_level_2"
        state += ', ' if state!=''
        state += place.address_components[i]['long_name']
        document.getElementById(addressType).value = place.address_components[i]['long_name']
      if addressType == "country"
        document.getElementById('profile_country').value = place.address_components[i]['long_name']
        document.getElementById('profile_country_code').value = place.address_components[i]['short_name']
      i++
    document.getElementById('profile_state').value = state
  window.autocomplete.addListener('place_changed', fillInAddress)
  return
$(document).on('turbolinks:load', ready)