function initMap() {
  let shop_lat = gon.shop_lat
  let shop_lng = gon.shop_lng
  
  var shop_map = new google.maps.Map(document.getElementById('shop-map'), {
    center: { lat: shop_lat, lng: shop_lng },
    streetViewControl: false,
    fullscreenControl: false,
    mapTypeControl: false,
    gestureHandling: 'greedy',
    zoom: 19,
  });

  var transitLayer = new google.maps.TransitLayer();
  transitLayer.setMap(shop_map);

  var shop_marker = new google.maps.Marker({
    position: { lat: shop_lat, lng: shop_lng },
    map: shop_map,
  });
}
window.initMap = initMap;