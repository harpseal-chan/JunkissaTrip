class ShopsController < ApplicationController
  def index
    result = @q.result
    @shops = result.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @shop.geocode
    gon.lat = @shop.latitude
    gon.lng = @shop.longitude
    @comment = Comment.new
    @comments = @shop.comments.page(params[:page]).order(updated_at: :desc).per(2)
  end
end
