# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require 'croppie'
#= require 'tagsinput'

ready_profiles = ->
#  $('#hobby_list').tagsinput({tagClass: 'badge-secondary'})
#  $('#film_list').tagsinput({tagClass: 'badge-secondary'})
#  $('#music_list').tagsinput({tagClass: 'badge-secondary'})
#  $('#book_list').tagsinput({tagClass: 'badge-secondary'})
  $('#profile_languages').select2({placeholder: "Select languages"});
  window.jcropInitialized = undefined
  window.crop = $('#avatar-image').croppie({
    boundary: {
      width: 400,
      height: 400
    },
    viewport: {
      width: 350,
      height: 350
    }
  })
  $('[data-modal-target="#edit-avatar"]').on 'click', ->
    x = $('#crop_x').val()*1
    y = $('#crop_y').val()*1
    w = x+$('#crop_w').val()*1
    h = y+$('#crop_h').val()*1
    prop = {
      url: crop[0].src,
      points: [x,y,w,h]
    }
    crop.croppie('bind', prop)
  $('#avatar-ok').on 'click', ->
    crop_result = crop.croppie('get').points
    c = new Object()
    c.x = crop_result[0]
    c.y = crop_result[1]
    c.w = crop_result[2] - c.x
    c.h = crop_result[3] - c.y
    setCoords(c)
    crop.croppie('result','base64').then (result) ->
      $('#avatar').attr 'src', result
      $('.modal').removeClass('show');
  initializeJcrop = ->
    w = Math.min($('#img_preview')[0].width,$('#img_preview')[0].height)
    scale = $('#img_preview')[0].naturalWidth/$('#img_preview').width()
    $('#img_preview').Jcrop({
      onSelect: setCoords,
      onChange: setCoords,
      setSelect: [0,0,w,w],
      minSize: [Math.round(540/scale),Math.round(540/scale)],
      aspectRatio: 1
    }, ->
      window.jcropInitialized = this
      return)
    return
  setCoords = (c) ->
    #    get width of scaled jcrop and divide to natural image width to obtain scale
    $('#crop_x').val(Math.round(c.x))
    $('#crop_y').val(Math.round(c.y))
    $('#crop_w').val(Math.round(c.w))
    $('#crop_h').val(Math.round(c.h))
    return
  if $('#img_preview').attr('src')!='#'
    $('#img_preview').on 'load', (e) ->
      scale = $('#img_preview')[0].naturalWidth/$('#img_preview').width()
      x = Math.round($('#crop_x').val()/scale)
      y = Math.round($('#crop_y').val()/scale)
      w = x+Math.round($('#crop_w').val()/scale)
      h = y+Math.round($('#crop_h').val()/scale)
      $('#img_preview').Jcrop({
        onSelect: setCoords,
        onChange: setCoords,
        setSelect: [x,y,w,h],
        minSize: [Math.round(540/scale),Math.round(540/scale)]
        aspectRatio: 1
      }, ->
        window.jcropInitialized = this
        return)
      return
  showError = (error) ->
    message = '<div class="alert alert-danger alert-dismissible fade show" role="alert">
                  <span class="message">' + error + '</span>
                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>'
    $('h1').after(message)
  resetFileInput = (input) ->
    input.type = ''
    input.type = 'file'
  validateImage = (e, input, target) ->
    if e.total > 2097152
      showError('Image is very large. Please select image less than 2mb')
      resetFileInput(input)
    else
      if e.target.result.match('image/jpeg|image/png|image/jpg')
        image = new Image()
        image.src = e.target.result
        image.input = input
        image.target = target
        image.onload = ->
          proportion = this.width/this.height
          if proportion < 0.5 || proportion > 2
            showError('One side of the image is much larger than other')
            resetFileInput(this.input)
          else
            if this.width>=760&&this.height>=760
              crop.croppie('bind',{url: this.src})
              this.target.attr 'src', this.src
            else
              showError('The image is small. Please select another.')
              resetFileInput(this.input)
      else
        showError('Wrong file type. Only images are acceptable')
        resetFileInput(input)
  readURL = (input) ->
    if input.files and input.files[0]
      reader = new FileReader
      reader.onloadend = (e) ->
        target =  $('#img_preview')
        target.on 'load', (e) ->
          if jcropInitialized
            jcropInitialized.destroy()
          initializeJcrop()
        validateImage(e, input, crop)
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
      photo_reader.onloadend = (e) ->
        target = $('#'+input.id).prev()
        validateImage(e,input,target)
        return
      photo_reader.readAsDataURL input.files[0]
      return
  options = {types: ['(cities)']}
  input = document.getElementById('profile_address');
  if input
    window.autocomplete = new google.maps.places.Autocomplete(input, options)
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
$(document).on('turbolinks:load', ready_profiles)