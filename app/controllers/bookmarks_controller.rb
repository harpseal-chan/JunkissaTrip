class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_shop, only: [:create, :destroy]

  def create
    bookmark = current_user.bookmarks.new(shop_id: @shop.id)
    bookmark.save
    respond_to do |format|
      format.html { redirect_to @shop }
      format.js
    end
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, shop_id: @shop.id)
    bookmark.destroy if bookmark.present?
    respond_to do |format|
      format.html { redirect_to @shop }
      format.js
    end
  end

  private

    def set_shop
      @shop = Shop.find_by(id: params[:shop_id])
    end
end
