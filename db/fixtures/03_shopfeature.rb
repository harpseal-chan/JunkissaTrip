[2, 3, 4, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 1
    s.shop_id = Shop.find_by(name: '喫茶ニカイ').id
    s.feature_id = feature_id
  end
end

[2, 5, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 2
    s.shop_id = Shop.find_by(name: '喫茶まりも').id
    s.feature_id = feature_id
  end
end

[1, 6, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 3
    s.shop_id = Shop.find_by(name: '珈琲道場 侍').id
    s.feature_id = feature_id
  end
end

[1, 3, 5, 6, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 4
    s.shop_id = Shop.find_by(name: 'ニューYC').id
    s.feature_id = feature_id
  end
end

[4, 5, 7, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 5
    s.shop_id = Shop.find_by(name: '喫茶＆Bar King of Kings').id
    s.feature_id = feature_id
  end
end

[5, 6, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 6
    s.shop_id = Shop.find_by(name: 'マヅラ喫茶店').id
    s.feature_id = feature_id
  end
end

[1, 3, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 7
    s.shop_id = Shop.find_by(name: 'イノダコーヒ 本店').id
    s.feature_id = feature_id
  end
end

[2].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 8
    s.shop_id = Shop.find_by(name: '喫茶ドレミ').id
    s.feature_id = feature_id
  end
end

[2, 4, 7, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 9
    s.shop_id = Shop.find_by(name: '喫茶ソワレ').id
    s.feature_id = feature_id
  end
end

[1, 3, 6, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 10
    s.shop_id = Shop.find_by(name: '可否道 平河町店').id
    s.feature_id = feature_id
  end
end

[3, 5].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 11
    s.shop_id = Shop.find_by(name: 'こぉひぃはうす 可否館').id
    s.feature_id = feature_id
  end
end

[2, 5].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 12
    s.shop_id = Shop.find_by(name: 'ブリッヂ').id
    s.feature_id = feature_id
  end
end

[1, 2, 3, 5, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 13
    s.shop_id = Shop.find_by(name: '珈琲専門店 エース').id
    s.feature_id = feature_id
  end
end

[5, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 14
    s.shop_id = Shop.find_by(name: '邪宗門').id
    s.feature_id = feature_id
  end
end

[4, 5, 7].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 15
    s.shop_id = Shop.find_by(name: 'アール座読書館').id
    s.feature_id = feature_id
  end
end

[7, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 16
    s.shop_id = Shop.find_by(name: '喫茶ココ').id
    s.feature_id = feature_id
  end
end

[2, 3, 4].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 17
    s.shop_id = Shop.find_by(name: 'チェリー').id
    s.feature_id = feature_id
  end
end

[3, 4, 5, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 18
    s.shop_id = Shop.find_by(name: '珈琲亭ルアン').id
    s.feature_id = feature_id
  end
end

[2, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 19
    s.shop_id = Shop.find_by(name: 'コーヒー＆プリン へッケルン').id
    s.feature_id = feature_id
  end
end

[2, 4, 5, 7].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 20
    s.shop_id = Shop.find_by(name: 'ショパン（CHOPIN）').id
    s.feature_id = feature_id
  end
end

[3, 4, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 21
    s.shop_id = Shop.find_by(name: 'gion').id
    s.feature_id = feature_id
  end
end

[1, 3, 5, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 22
    s.shop_id = Shop.find_by(name: '神田珈琲園 神田駅北口店').id
    s.feature_id = feature_id
  end
end

[2, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 23
    s.shop_id = Shop.find_by(name: 'サンバード').id
    s.feature_id = feature_id
  end
end

[1, 7].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 24
    s.shop_id = Shop.find_by(name: 'DUN AROMA（ダン アロマ）').id
    s.feature_id = feature_id
  end
end

[1, 2, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 25
    s.shop_id = Shop.find_by(name: '喫茶サンシャイン').id
    s.feature_id = feature_id
  end
end

[7, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 26
    s.shop_id = Shop.find_by(name: 'コーヒーの大学院 ルミエール・ド・パリ').id
    s.feature_id = feature_id
  end
end

[5, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 27
    s.shop_id = Shop.find_by(name: 'シビタス').id
    s.feature_id = feature_id
  end
end

[2, 5, 6].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 28
    s.shop_id = Shop.find_by(name: 'サガン').id
    s.feature_id = feature_id
  end
end

[2, 4, 5, 7, 8].each do |feature_id|
  ShopFeature.seed do |s|
    s.id = 29
    s.shop_id = Shop.find_by(name: '喫茶 宝石箱').id
    s.feature_id = feature_id
  end
end
