class MapsController < ApplicationController
  def search
    @q = Shop.ransack(params[:q])
    @shops = @q.result
    @features = Feature.all
    gon.shops = @shops
    gon.shop_features = ShopFeature.all
  end
end
