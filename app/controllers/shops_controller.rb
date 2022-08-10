class ShopsController < ApplicationController
  def index
    result = @q.result
    @shops = result.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @comment = Comment.new
    @comments = @shop.comments
  end
end
