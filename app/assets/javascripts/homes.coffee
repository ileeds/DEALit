# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


window.changeName = (id)->

  if document.getElementById(id).innerHTML == 'More options'
    txt = 'User cancelled the prompt.'
    document.getElementById(id).innerHTML = 'Less options'
  else
    document.getElementById(id).innerHTML = 'More options'
  return

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
    marker.setAttribute 'class', 'marker_container1'
    marker.setAttribute 'id', @args.id
    marker.innerHTML = @args.price
    console.log(@args.id);

    { content: marker }

  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow
    #console.log(this.marker.serviceObject.content);
    #if document.getElementById('clicked')

      #document.getElementById('clicked').id = ''


    #this.marker.serviceObject.content.id = 'clicked'
    boxText = document.createElement("div")
    boxText.setAttribute('class', 'marker_container')

     #to customize
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

  #then standard use
  handler.buildMap { provider: {}, internal: {id: 'map'} }, ->
    markers = handler.addMarkers(markers)
    handler.bounds.extendWith(markers)
    handler.fitMapToBounds()

$(document).on 'click', '.marker_container1', ->
  console.log(this.id);
  $('.clicked').removeClass().addClass 'marker_container1'
  $(this).removeClass('marker_container1').addClass 'clicked'
  $('.box').css 'background-color', 'white'
  $('#' + this.id + '.box').css 'background-color', 'yellow'
  $container = $('#index')
  $scrollTo = $('#' + @id + '.box')
  $container.scrollTop $scrollTo.offset().top - ($container.offset().top) + $container.scrollTop()- ($container.height()/2)
  return
