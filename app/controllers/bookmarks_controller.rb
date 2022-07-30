class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_shop, only: [:create, :destroy]

  def create
    # Rails.logger.debug @user.inspect
    # @user.methods
    @bookmark = Bookmark.new(user_id: current_user.id, shop_id: @shop.id)
    if @bookmark.save
      flash[:success] = 'ブックマーク成功'
    else
      flash[:danger] = 'ブックマーク失敗'
    end
    render "shops/show"
  end

  def destroy
    @bookmark = Bookmark.find_by(user_id: current_user.id, shop_id: @shop.id)
    @bookmark.destroy
  end

  private

    def set_shop
      @shop = Shop.find_by(id: params[:shop_id])
    end
end
