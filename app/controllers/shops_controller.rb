class ShopsController < ApplicationController
  def index
    result = @q.result
    @shops = result.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
  end
end
