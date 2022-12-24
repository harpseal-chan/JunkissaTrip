class MapsController < ApplicationController
  def search
    @shops = Shop.all
    @features = Feature.all
    gon.shops = @shops
    gon.shop_features = ShopFeature.all
  end
end
