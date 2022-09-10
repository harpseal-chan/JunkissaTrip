class Admin::ShopsController < ApplicationController
  def index
    @shops = Shop.all
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
      params.require(:shop).permit(:name, :address, :phone, :opening, :closed)
    end
end
