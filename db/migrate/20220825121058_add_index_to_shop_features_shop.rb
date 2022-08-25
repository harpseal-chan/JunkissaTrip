class AddIndexToShopFeaturesShop < ActiveRecord::Migration[6.1]
  def change
    add_index :shop_features, [:shop_id, :feature_id], unique: true
  end
end
