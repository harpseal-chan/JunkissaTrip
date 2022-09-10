class Admin::ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end

  def edit
    @shop = Shop.find(params[:id])
  end
end
