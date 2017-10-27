# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  price_slider = $('#price_slider').slider(
    range: true
    min: parseInt $('#price_hidden').attr 'total-min'
    max: parseInt $('#price_hidden').attr 'total-max'
    values: [
      $('#price_hidden').attr 'min'
      $('#price_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_price').val ui.values[0]
      $('#max_price').val ui.values[1]
      $('#min_price_label').text ui.values[0]
      $('#max_price_label').text ui.values[1]
  )
  $('#min_price').val price_slider.slider('values')[0]
  $('#max_price').val price_slider.slider('values')[1]

  total_rooms_slider = $('#total_rooms_slider').slider(
    range: true
    min: parseInt $('#total_rooms_hidden').attr 'total-min'
    max: parseInt $('#total_rooms_hidden').attr 'total-max'
    values: [
      $('#total_rooms_hidden').attr 'min'
      $('#total_rooms_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_total_rooms').val ui.values[0]
      $('#max_total_rooms').val ui.values[1]
      $('#min_total_rooms_label').text ui.values[0]
      $('#max_total_rooms_label').text ui.values[1]
  )
  $('#min_total_rooms').val total_rooms_slider.slider('values')[0]
  $('#max_total_rooms').val total_rooms_slider.slider('values')[1]

  available_rooms_slider = $('#available_rooms_slider').slider(
    range: true
    min: parseInt $('#available_rooms_hidden').attr 'total-min'
    max: parseInt $('#available_rooms_hidden').attr 'total-max'
    values: [
      $('#available_rooms_hidden').attr 'min'
      $('#available_rooms_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_available_rooms').val ui.values[0]
      $('#max_available_rooms').val ui.values[1]
      $('#min_available_rooms_label').text ui.values[0]
      $('#max_available_rooms_label').text ui.values[1]
  )
  $('#min_available_rooms').val available_rooms_slider.slider('values')[0]
  $('#max_available_rooms').val available_rooms_slider.slider('values')[1]

  total_bathrooms_slider = $('#total_bathrooms_slider').slider(
    range: true
    min: parseInt $('#total_bathrooms_hidden').attr 'total-min'
    max: parseInt $('#total_bathrooms_hidden').attr 'total-max'
    values: [
      $('#total_bathrooms_hidden').attr 'min'
      $('#total_bathrooms_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_total_bathrooms').val ui.values[0]
      $('#max_total_bathrooms').val ui.values[1]
      $('#min_total_bathrooms_label').text ui.values[0]
      $('#max_total_bathrooms_label').text ui.values[1]
  )
  $('#min_total_bathrooms').val total_bathrooms_slider.slider('values')[0]
  $('#max_total_bathrooms').val total_bathrooms_slider.slider('values')[1]

  private_bathrooms_slider = $('#private_bathrooms_slider').slider(
    range: true
    min: parseInt $('#private_bathrooms_hidden').attr 'total-min'
    max: parseInt $('#private_bathrooms_hidden').attr 'total-max'
    values: [
      $('#private_bathrooms_hidden').attr 'min'
      $('#private_bathrooms_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_private_bathrooms').val ui.values[0]
      $('#max_private_bathrooms').val ui.values[1]
      $('#min_private_bathrooms_label').text ui.values[0]
      $('#max_private_bathrooms_label').text ui.values[1]
  )
  $('#min_private_bathrooms').val private_bathrooms_slider.slider('values')[0]
  $('#max_private_bathrooms').val private_bathrooms_slider.slider('values')[1]

class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  #override create_marker method
  create_marker: ->
    options = _.extend @marker_options(), @rich_marker_options()
    @serviceObject = new RichMarker options #assign marker to @serviceObject

  rich_marker_options: ->
    marker = document.createElement("div")
    marker.setAttribute 'class', 'marker_container'
    marker.innerHTML = @args.price
    { content: marker }

  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute('class', 'marker_container') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, 0)
    boxStyle:
      width: "280px"

@buildMap = (markers)->
  handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection

  #then standard use
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
