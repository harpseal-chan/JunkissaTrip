class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:create, :destroy]

  def create
    @user = current_user
    @bookmark = Bookmark.new(user_id: @user.id, shop_id: @shop.id)
    @bookmark.save
  end

  def destroy
    bookmark = current_user.bookmarks.find_by!(shop_id: @shop.id)
    bookmark.destroy!
  end

  private

    def set_shop
      @shop = Shop.find(params[:shop_id])
    end
end
