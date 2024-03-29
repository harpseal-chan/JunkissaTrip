let map = null;
let shopInfoWindow;
let currentInfoWindow = null;
const shopFeatures = gon.shop_features;
const Features = gon.features;

function initSearchMap() {

  // マップの初期化
  map = new google.maps.Map(document.getElementById('search-map'), {
    center: { lat: 35.681236, lng: 139.767125 },
    streetViewControl: false,
    fullscreenControl: false,
    mapTypeControl: false,
    gestureHandling: 'auto',
    zoom: 14,
  });

  //　店舗情報の初期化
  initShopInfo(gon.shops);

  // 現在地へ移動ボタンを追加
  const currentLocationBtn = document.createElement('button');
  currentLocationBtn.textContent = '現在地へ移動';
  currentLocationBtn.classList.add("btn", "btn-cur-lo");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(currentLocationBtn);
  
  currentLocationBtn.addEventListener('click', () => {
    // 現在地へ移動
    moveCurrentLocation();
  });

  // マップの任意の場所をクリックすると店舗情報ウィンドウを閉じる
  google.maps.event.addListener(map, 'click', () => {
    shopInfoWindow.close(); 
  });
}

initShopInfo = (shops) => {
  let shopMarkers = [];
  
  for (let i = 0; i < shops.length; i++) {
    // 店舗の緯度・経度取得
    LatLng = new google.maps.LatLng({
      lat: parseFloat(shops[i]['latitude']),
      lng: parseFloat(shops[i]['longitude'])
    });

    // 店舗マーカーの作成
    shopMarkers[i] = new google.maps.Marker({
      position: LatLng,
      map: map,
      icon: {
        path: google.maps.SymbolPath.CIRCLE,
        fillColor: "#653e03",
        fillOpacity: 1.0,
        scale: 10,
        strokeColor: "#653e03",
        strokeWeight: 1.0
      },
      animation: google.maps.Animation.DROP
    });

    // 店舗マーカークリック時に店舗情報ウィンドウを表示
    shopMarkers[i].addListener('click', function(){
      updateShopInfoWindow(shopMarkers[i], shops[i]);
    });
  }
}

updateShopInfoWindow = (shopMarker, shop) => {
  // 店舗の特徴を取得
  const filteredSFs = shopFeatures.filter((v) => v.shop_id === shop.id);
  let features = [];
  for (var i=0; i<filteredSFs.length; i++) {
    features.push(Features.find((v) => v.id === filteredSFs[i].feature_id));
  }
  let feature = "";
  for (var i=0; i<features.length; i++) {
    feature +=
    '<div class="feature">' +
      '<li class="feature-detail">' +
        '<img alt="' + features[i].detail + '" src=/assets/' + features[i].icon_name + ' class="feature-icon">' + features[i].detail +
      '</li>' +
    '</div>';
  }
  
  // 店舗情報ウィンドウのHTML要素
  const contentHtml =
  '<h4>' + shop.name + '</h4>' +
  '<div class="shop-info">' +
    '<h5 class="title">住所</h5>' +
    '<p class="content">' + shop.address + '</p>' +
  '</div>' +
  '<div class="shop-info">' +
    '<h5 class="title">営業時間</h5>' +
    '<p class="content">' + shop.opening + '</p>' +
  '</div>' +
  '<div class="shop-info">' +
    '<h5 class="title">定休日</h5>' +
    '<p class="content">' + shop.closed + '</p>' +
  '</div>' +
  '<h5 class="title">特徴</h5>' +
  feature +
  '<a class="detail" href="/shops/' + shop.id + '">詳細ページへ</a>';

  // 現在開いているウィンドウを閉じる
  if(currentInfoWindow) {
    currentInfoWindow.close();
  }

  // 店舗情報ウィンドウの作成
  shopInfoWindow = new google.maps.InfoWindow({
    content: contentHtml,
    maxWidth: 200,
  });

  // 店舗情報ウィンドウを開く
  shopInfoWindow.open({
    anchor: shopMarker,
    map,
  });

  currentInfoWindow = shopInfoWindow;
}

moveCurrentLocation = () => {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(
      (position) => {
        var pos = {
          lat: position.coords.latitude,
          lng: position.coords.longitude,
        };
        map.setCenter(pos);
      },
      (error) => {
        var errorInfo = [
          '原因不明のエラーが発生しました',
          'ウェブサイトの許可を得ていないため位置情報の取得に失敗しました。',
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
}

window.initMap = initSearchMap;