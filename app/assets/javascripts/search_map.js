function initSearchMap() {
  let lat = gon.lat
  let lng = gon.lng
  
  // マップの初期化
  var map = new google.maps.Map(document.getElementById('search-map'), {
    center: { lat: lat, lng: lng },
    streetViewControl: false,
    // scrollwheel: false,
    fullscreenControl: false,
    mapTypeControl: false,
    gestureHandling: 'greedy',
    zoom: 14,
  });

  // ピンの初期化
  var marker = new google.maps.Marker({
    position: { lat: lat, lng: lng },
    map: map,
    animation: google.maps.Animation.DROP
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  // サークルの初期化
  var circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1500,
    clickable: false,
    fillColor: '#653e03',
    fillOpacity: 0.1,
    strokeColor: '#653e03',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });

  var shopMarkers = [];
  if (gon.shops) {
    for (let i = 0; i < gon.shops.length; i++) {
      // 店舗の座標取得
      markerLatLng = new google.maps.LatLng({
        lat: parseFloat(gon.shops[i]['latitude']),
        lng: parseFloat(gon.shops[i]['longitude'])
      });

      // 店舗マーカーの作成
      shopMarkers[i] = new google.maps.Marker({
        position: markerLatLng,
        map: map,
        animation: google.maps.Animation.DROP
      });
    }
  }
}