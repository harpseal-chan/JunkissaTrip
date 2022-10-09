let lat = gon.lat;
let lng = gon.lng;
let map = null
let marker = null;
let circle = null;
let shops = gon.shops
let shopMarkers = [];
let shopInfoWindows = [];

function initSearchMap() {

  // マップの初期化
  map = new google.maps.Map(document.getElementById('search-map'), {
    center: { lat: lat, lng: lng },
    streetViewControl: false,
    // scrollwheel: false,
    fullscreenControl: false,
    mapTypeControl: false,
    gestureHandling: 'greedy',
    zoom: 14,
  });

  // マーカーの初期化
  marker = new google.maps.Marker({
    position: { lat: lat, lng: lng },
    map: map,
    animation: google.maps.Animation.DROP,
  });

  marker.addListener('click', function() {
    infowindow.open(map, marker);
  });

  // サークルの初期化
  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1000,
    clickable: false,
    fillColor: '#653e03',
    fillOpacity: 0.1,
    strokeColor: '#653e03',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });

  if (shops) {
    initShopInfo();
  }

  // マーカーの移動
  map.addListener('click', function(e){
    clickMap(e.latLng, map);
  });
}

window.initMap = initSearchMap;

clickMap = (lat_lng, map) => {
  lat = lat_lng.lat();
  lng = lat_lng.lng();

  lat = Math.floor(lat * 10000000) / 10000000;
  lng = Math.floor(lng * 10000000) / 10000000;

  //緯度経度をformに入力する
  document.getElementById('lat').value = lat;
  document.getElementById('lng').value = lng;

  //中心に移動
  map.panTo(lat_lng);

  // マーカーとサークルの更新
  updateMarker(lat_lng, map);
  updateCircle(lat, lng, map);
}

updateMarker = (pos, map) => {
  marker.setMap(null);
  marker = null;
  marker = new google.maps.Marker({
    position: pos,
    map: map
  });
}

updateCircle = (lat, lng, map) => {
  circle.setMap(null);
  circle = null;
  circle = new google.maps.Circle({
    center: new google.maps.LatLng(lat, lng),
    map: map,
    radius: 1000,
    clickable: false,
    fillColor: '#653e03',
    fillOpacity: 0.1,
    strokeColor: '#653e03',
    strokeOpacity: 0.6,
    strokeWeight: 0.7,
  });
}

initShopInfo = () => {
  const labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  let labelIndex = 0;

  for (let i = 0; i < shops.length; i++) {
    // 店舗の緯度・経度取得
    markerLatLng = new google.maps.LatLng({
      lat: parseFloat(shops[i]['latitude']),
      lng: parseFloat(shops[i]['longitude'])
    });

    // 店舗マーカーの作成
    shopMarkers[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      label: {
        text: labels[labelIndex++ % labels.length],
        color: '#f7f6f2',
        fontSize: '18px'
      },
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: "#653e03",
        fillOpacity: 1.0,
        scale: 14,
        strokeColor: "#653e03",
        strokeWeight: 1.0
      },
      animation: google.maps.Animation.DROP
    });

    // 店舗情報ウィンドウの作成
    let id = shops[i]['id']
    shopInfoWindows[i] = new google.maps.InfoWindow({
      content: `<a href='/shops/${id}'>${shops[i].name}</a>`
    });
    // shopInfoWindows[i].open(map, shopMarkers[i]);
  }
}