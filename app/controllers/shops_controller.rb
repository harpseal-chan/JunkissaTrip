class ShopsController < ApplicationController
  def index
    @shops = Shop.all.page(params[:page])
  end
end
