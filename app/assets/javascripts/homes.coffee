# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  slider = $('#price_slider').slider(
    range: true
    min: parseInt $('#hidden').attr 'total-min'
    max: parseInt $('#hidden').attr 'total-max'
    values: [
      $('#hidden').attr 'data-min'
      $('#hidden').attr 'data-max'
    ]
    slide: (event, ui) ->
      $('#min_price').val ui.values[0]
      $('#max_price').val ui.values[1]
      $('#min_price_label').text ui.values[0]
      $('#max_price_label').text ui.values[1]
      return
  )
  $('#min_price').val slider.slider('values')[0]
  $('#max_price').val slider.slider('values')[1]
  return

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
