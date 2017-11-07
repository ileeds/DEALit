var init;

init = function() {
  var autocomplete, input;
  input = document.getElementById('home_address');
  autocomplete = new google.maps.places.Autocomplete(input);
};

google.maps.event.addDomListener(window, 'load', init);
