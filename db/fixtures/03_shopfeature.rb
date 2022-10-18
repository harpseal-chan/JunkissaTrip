feature_id_list = [
  { id: 1, feature_ids: [2, 3, 4, 8] },
  { id: 2, feature_ids: [2, 5, 6] },
  { id: 3, feature_ids: [1, 6, 8] },
  { id: 4, feature_ids: [1, 3, 5, 6, 8] },
  { id: 5, feature_ids: [4, 5, 7, 8] },
  { id: 6, feature_ids: [5, 6, 8] },
  { id: 7, feature_ids: [1, 3, 6] },
  { id: 8, feature_ids: [2] },
  { id: 9, feature_ids: [2, 4, 7, 8] },
  { id: 10, feature_ids: [1, 3, 6, 8] },
  { id: 11, feature_ids: [3, 5] },
  { id: 12, feature_ids: [2, 5] },
  { id: 13, feature_ids: [1, 2, 3, 5, 8] },
  { id: 14, feature_ids: [5, 8] },
  { id: 15, feature_ids: [4, 5, 7] },
  { id: 16, feature_ids: [7, 8] },
  { id: 17, feature_ids: [2, 3, 4] },
  { id: 18, feature_ids: [3, 4, 5, 8] },
  { id: 19, feature_ids: [2, 6] },
  { id: 20, feature_ids: [2, 4, 5, 7] },
  { id: 21, feature_ids: [3, 4, 8] },
  { id: 22, feature_ids: [1, 3, 5, 6] },
  { id: 23, feature_ids: [2, 8] },
  { id: 24, feature_ids: [1, 7] },
  { id: 25, feature_ids: [1, 2, 6] },
  { id: 26, feature_ids: [7, 8] },
  { id: 27, feature_ids: [5, 8] },
  { id: 28, feature_ids: [2, 5, 6] },
  { id: 29, feature_ids: [2, 4, 5, 7, 8] },
  { id: 30, feature_ids: [4, 5, 7, 8] },
  { id: 31, feature_ids: [1, 2, 5, 6, 8] },
  { id: 32, feature_ids: [1, 2, 5] },
  { id: 33, feature_ids: [5, 7, 8] },
  { id: 34, feature_ids: [4, 5] },
  { id: 35, feature_ids: [2, 5, 7] },
  { id: 36, feature_ids: [3, 5, 7, 8] },
  { id: 37, feature_ids: [3, 6, 8] },
  { id: 38, feature_ids: [4, 5] },
  { id: 39, feature_ids: [1, 3, 5, 7, 8] },
  { id: 40, feature_ids: [2, 5, 6] },
  { id: 41, feature_ids: [2, 3, 6, 8] },
  { id: 42, feature_ids: [2, 3, 6, 8] },
  { id: 43, feature_ids: [4, 5] },
]

i = 1
Shop.all.ids.sort.each do |shop_id|
  feature_id_list[shop_id - 1][:feature_ids].each do |feature_id|
    ShopFeature.seed do |s|
      s.id = i 
      s.shop_id = shop_id
      s.feature_id = feature_id
    end
    i += 1
  end
end
