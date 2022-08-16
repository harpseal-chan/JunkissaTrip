class ShopsController < ApplicationController
  def index
    result = @q.result
    @shops = result.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @comment = Comment.new
    @comments = @shop.comments.page(params[:page]).order(updated_at: :desc).per(2)
  end
end
