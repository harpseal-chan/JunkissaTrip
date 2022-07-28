class ShopsController < ApplicationController
  def index
    @shops = Shop.all.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
