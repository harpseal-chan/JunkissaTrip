class ShopFeature < ApplicationRecord
  belongs_to :shop
  belongs_to :feature

  validates_uniqueness_of :shop_id, scope: :feature_id
end
