# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#= require dropzone.min
$(document).on 'click', '#photos_new', ->
  $('.photos_show').toggle()
  if document.getElementById("photos_new").innerHTML == 'Hide'
    document.getElementById("photos_new").innerHTML = 'See and upload photos'
  else
    document.getElementById("photos_new").innerHTML = 'Hide'
  return

  document.getElementById("pictureInput").onchange = ->
  document.getElementById("form_ajax-1").submit()
  return

$ ->
  $('#pictureInput').on 'change', (event) ->
    event.target.files==null
    files = event.target.files
    i = 0
    while i < files.length
      image = files[i]
      reader = new FileReader
      reader.onload = (file) ->
        img = new Image
        console.log img
        img.src = file.target.result
        $('#target').append img
        $('#target').append "<strong> </strong>"
        return
      reader.readAsDataURL image
      i++
      console.log($('#form-ajax-1').submit())
    return
  return

  document.getElementById('pictureInput').onchange = ->
  document.getElementById('form-ajax-1').submit()
  return
