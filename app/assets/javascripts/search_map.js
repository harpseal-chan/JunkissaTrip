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
    radius: 1500,
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

  // 現在地へ移動ボタン
  const currentLocation = document.createElement('button');
  currentLocation.textContent = '現在地へ移動';
  currentLocation.classList.add("btn", "btn-cur-lo");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(currentLocation);

  currentLocation.addEventListener('click', () => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          var pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude,
          };
          map.setCenter(pos);
          updateMarker(pos, map);
          updateCircle(pos.lat, pos.lng, map);
          document.getElementById('lat').value = pos.lat;
          document.getElementById('lng').value = pos.lng;
        },
        (error) => {
          var errorInfo = [
            '原因不明のエラーが発生しました',
            'ページが許可を得ていないため、位置情報の取得に失敗しました。',
            '内部エラー発生により位置情報の取得に失敗しました。',
            'タイムアウトにより位置情報の取得に失敗しました。'
          ];

          var errorMessage = errorInfo[error.code]
          alert(errorMessage);
        }
      );
    } else {
      window.alert('ご使用の端末では対応しておりません。');
    }
  });
}

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
    radius: 1500,
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
    let labelText = labels[labelIndex++ % labels.length]

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
        text: labelText,
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

    let label_id = "result-label-" + (i + 1).toString();
    document.getElementById(label_id).textContent = labelText;
  }
}

window.initMap = initSearchMap;