# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
hashmap={}
generate_slider = (slider_name)->
  this_slider = $('#' + slider_name + '_slider').slider(
    range: true
    min: parseInt $('#' + slider_name + '_hidden').attr 'total-min'
    max: parseInt $('#' + slider_name + '_hidden').attr 'total-max'
    values: [
      $('#' + slider_name + '_hidden').attr 'min'
      $('#' + slider_name + '_hidden').attr 'max'
    ]
    slide: (event, ui) ->
      $('#min_' + slider_name).val ui.values[0]
      $('#max_' + slider_name).val ui.values[1]
      $('#min_' + slider_name).text ui.values[0]
      $('#max_' + slider_name).text ui.values[1]
      $('#filterrific-form').delay(200).submit()
      $('#savesearch').show();
  )
  $('#min_' + slider_name).val this_slider.slider('values')[0]
  $('#max_' + slider_name).val this_slider.slider('values')[1]

window.changeName = (id)->
  if document.getElementById(id).innerHTML == 'More options'
    document.getElementById(id).innerHTML = 'Less options'
  else
    document.getElementById(id).innerHTML = 'More options'
  return

$(document).ready ->
  generate_slider('price')
  generate_slider('total_rooms')
  generate_slider('available_rooms')
  generate_slider('total_bathrooms')
  generate_slider('private_bathrooms')
  generate_slider('distance')
  generate_slider('driving_duration')
  generate_slider('bicycling_duration')
  generate_slider('transit_duration')
  generate_slider('walking_duration')

  $('.select-filter').on "change", ->
    $('#filterrific-form').submit()


class RichMarkerBuilder extends Gmaps.Google.Builders.Marker #inherit from builtin builder
  #override create_marker method
  create_marker: ->
    options = _.extend @marker_options(), @rich_marker_options()
    @serviceObject = new RichMarker options #assign marker to @serviceObject

  rich_marker_options: ->
    marker = document.createElement("div")
    marker.setAttribute 'class', 'marker_container1'
    marker.setAttribute 'id', @args.id
    hashmap[@args.id]=marker
    marker.innerHTML = "$"+@args.price
    { content: marker }

  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow
    boxText = document.createElement("div")
    boxText.setAttribute('class', 'marker_container')
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText
    pixelOffset: new google.maps.Size(-140, -50)
    boxStyle:
      width: "120px"
    closeBoxMargin: "-111px -53px 111px 0px"
    infoBoxClearance: new google.maps.Size(1, 2)

@buildMap = (markers)->
  handler = Gmaps.build 'Google', { builders: { Marker: RichMarkerBuilder} } #dependency injection
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()
    map = handler.getMap()
    if map.zoom > 12
      map.setZoom(12)

$(document).on 'click', '.marker_container1', ->
  $('.clicked').removeClass().addClass 'marker_container1'
  $(this).removeClass('marker_container1').addClass 'clicked'
  $('.box').css 'background-color', 'transparent'
  $container = $('#index')
  $scrollTo = $('#' + @id + '.box')
  $container.scrollTop $scrollTo.offset().top - ($container.offset().top) + $container.scrollTop()- ($container.height()/2)
  return

$(document).on 'mouseover', ('.box, .home-photo'), ->
  $('#'+@id+'.marker_container1').css 'color', 'red'
  $('#'+@id+'.clicked').css 'color', 'red'
  return

$(document).on 'mouseout', ('.box, .home-photo'), ->
  $('.marker_container1').css 'color', 'black'
  $('.clicked').css 'color', 'black'
  return

$(document).on 'hidden.bs.modal', '.modal', ->
  $('#index').css 'overflow-y', 'scroll'
  return


 $('form_ajax1').submit ->
  valuesToSubmit = $(this).serialize()
  $.ajax(
    type: 'POST'
    url: $(this).attr('action')
    data: valuesToSubmit
    dataType: 'JSON').success (json) ->
    console.log 'success', json
    return
  false

  $('form#form_ajax1').trigger('submit.rails');

  document.getElementById('pictureInput').onchange = ->
  document.getElementById('form_ajax1').submit()
  return
