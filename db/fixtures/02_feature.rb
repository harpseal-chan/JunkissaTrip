[
  [1, 'coffee-beans', 'コーヒーにこだわりあり'],
  [2, 'cake-slice', 'スイーツメニューが充実'],
  [3, 'fork-knife', '食事メニューが充実'],
  [4, 'glass', 'ドリンクメニューが充実'],
  [5, 'person', '一人でも入りやすい'],
  [6, 'comments', '話しやすい雰囲気'],
  [7, 'book-open-reader', '静かな雰囲気'],
  [8, 'couch', 'インテリアがおしゃれ']
].each do |id, icon_name, detail|
  Feature.create!(
    { id: id, icon_name: icon_name, detail: detail }
  )
end