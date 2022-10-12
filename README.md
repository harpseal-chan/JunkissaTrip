# <img width="23px" height="23px" alt="アイコン" src="https://user-images.githubusercontent.com/102633054/190850730-e87072d0-e748-429f-9249-fb8560ad3ef6.png">  純喫茶Trip

__「レトロな純喫茶」に特化した情報サイト__<br>
<br>
店舗名やエリア名の検索、純喫茶の特徴による絞り込みであなた好みの純喫茶を見つけられます。<br>
また、ブックマーク機能やコメント投稿で来店の記録を保存・共有することができます。<br>

__URL__ : https://junkissa-trip.link/

<br>
◆ 純喫茶とは？<br>

Wikipediaによると「酒類を扱わない、純粋な喫茶店」と定義されていますが、<br>
本サイトでは、以下の特徴がある喫茶店をすべて純喫茶としています。
<br>

- 昭和レトロまたはクラシックな内観・外観のお店
- クリームソーダやナポリタンなど昔懐かしいメニューを提供している

<br>

## :bulb: 制作背景

私は純喫茶巡りが趣味で、普段はSNSや地図アプリを使用して行きたいお店を探しています。<br>
しかし、検索結果にチェーン店のカフェも含まれるため、純喫茶を探すのに時間がかかることがありました。<br>
そこで純喫茶に特化した情報アプリがあれば、好みのお店をすぐに見つけられるのではと考え、アプリ作成に取り組みました。<br>

<br>

## :dart: ターゲット

- 純喫茶に行ってみたいけど、どんなお店があるのか知らない人
- レトロなインテリアや食べ物が好きな人
- 静かで落ち着く場所を求めている人

<br>

## :coffee: コア機能

### 1. 店舗検索, 絞り込み

店舗名や住所で検索することができます。<br>
店舗一覧ページでは、店舗の特徴（静かな雰囲気、コーヒーにこだわり有り等）から絞り込み検索することも可能です。
<br>

<img alt="店舗検索" src="https://user-images.githubusercontent.com/102633054/190966780-72f24bd9-360c-4193-b853-86276a2144c0.gif">

<br>

___

<br>

### 2. ブックマーク登録, コメント投稿機能

店舗をブックマーク登録することで、気になるお店をいつでも確認できます。<br>
コメント投稿で来店の記録を保存・共有することができます。

<img alt="店舗検索" src="https://user-images.githubusercontent.com/102633054/190967623-d3c9d13f-9966-451e-9866-9dc6e0108ade.gif">

<br>

___

<br>

ブックマーク登録した店舗や投稿したコメントは、マイページにて確認できます。

<img height="383px" width="700px" alt="マイページ" src="https://user-images.githubusercontent.com/102633054/191004706-66ecfd83-058c-4b64-996a-318d11931177.png">

<br>

## :computer: 使用技術

__フロントエンド__

- HTML / SCSS
- CSS framework
  - bootstrap-sass 3.4.1
- jQuery 3.4.1

__バックエンド__

- Ruby 2.7.4
- Rails 6.1.4

__使用ツール__

- RSpec（テスト）
- rubocop（静的解析）
- kaminari（ページネーション）
- Google Maps JavaScript API, Maps Embed API, geokit-rails（マップ検索）
- ransack（店舗検索）
- Active Storage（画像アップロード）

<br>

__インフラ構成図 / 開発環境__

- インフラ：AWS（EC2, RDS, S3, Route53, ALBほか）
- 開発環境：docker-compose
- デプロイツール： Caspitrano

<img alt="インフラ構成図" src="https://user-images.githubusercontent.com/102633054/191001150-ffb6e6e3-9727-4c34-9831-37ac11e3ee35.png">

<br>

## ER図

<img alt="ER図" src="https://user-images.githubusercontent.com/102633054/195459298-45533694-df9d-4f72-8815-d21c7fd6c692.png">
