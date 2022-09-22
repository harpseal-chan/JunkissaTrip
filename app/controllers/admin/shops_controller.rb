class Admin::ShopsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @shops = Shop.all.preload(images_attachments: :blob)
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = '店舗情報を更新しました'
      redirect_to admin_shops_url
    else
      render :edit
    end
  end

  private

    def shop_params
      params.require(:shop).permit(:name, :address, :phone, :opening, :closed, :image, images: [])
    end
end
