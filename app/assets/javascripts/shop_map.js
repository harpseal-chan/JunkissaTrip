function initMap() {
  let lat = gon.lat
  let lng = gon.lng
  
  var map = new google.maps.Map(document.getElementById('shop-map'), {
    center: {
      lat: lat,
      lng: lng
    },
    zoom: 19,
  });

  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(map);

  var marker = new google.maps.Marker({
                position: {
                  lat: lat,
                  lng: lng
                },
                map: map,
                });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });
}