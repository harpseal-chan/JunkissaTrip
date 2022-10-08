class ShopsController < ApplicationController
  def index
    result = @q.result.preload(:features, images_attachments: :blob)
    @shops = result.page(params[:page])
    @features = Feature.all
  end

  def show
    @shop = Shop.preload(images_attachments: :blob).find(params[:id])
    gon.lat = @shop.latitude
    gon.lng = @shop.longitude
    @new_comment = Comment.new
    @comments = @shop.comments.preload(:user).page(params[:page]).order(updated_at: :desc).per(2)
  end
end
