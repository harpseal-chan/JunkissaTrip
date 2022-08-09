class ShopsController < ApplicationController
  def index
    result = @q.result
    @shops = result.page(params[:page])
  end

  def show
    @shop = Shop.find(params[:id])
    @comment = current_user.comments.new
  end
end
