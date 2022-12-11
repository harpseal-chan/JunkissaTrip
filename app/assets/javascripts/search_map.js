let map = null;
let shops = gon.shops;
let shopInfoWindows;

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
  initShopInfo();

  // 現在地へ移動ボタンを追加
  const currentLocation = document.createElement('button');
  currentLocation.textContent = '現在地へ移動';
  currentLocation.classList.add("btn", "btn-cur-lo");
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(currentLocation);

  // 現在地へ移動
  currentLocation.addEventListener('click', () => {
    moveCurrentLocation();
  });

  google.maps.event.addDomListener(map, "click", function () {
    shopInfoWindows.close(); 
  });
}

initShopInfo = () => {
  let shopMarkers = [];
  
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

    shopMarkers[i].addListener('click', function(){

      // 店舗情報ウィンドウのHTML要素
      const contentHtml =
        '<h4>' + shops[i].name + '</h4>' +
        '<div class="shop-info">' +
          '<h5 class="title">住所</h5>' +
          '<p class="content">' + shops[i].address + '</p>' +
        '</div>' +
        '<div class="shop-info">' +
          '<h5 class="title">営業時間</h5>' +
          '<p class="content">' + shops[i].opening + '</p>' +
        '</div>' +
        '<div class="shop-info">' +
          '<h5 class="title">定休日</h5>' +
          '<p class="content">' + shops[i].closed + '</p>' +
        '</div>' + 
        '<a class="detail" href="/shops/' + shops[i].id + '">詳細ページへ</a>';
  
      // 店舗情報ウィンドウの作成
      shopInfoWindows = new google.maps.InfoWindow({
        content: contentHtml,
        maxWidth: 200,
      });

      // 店舗情報ウィンドウを開く
      shopInfoWindows.open({
        anchor: shopMarkers[i],
        map,
      });
    });
  }
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