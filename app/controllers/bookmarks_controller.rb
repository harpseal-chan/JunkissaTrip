class BookmarksController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :set_shop, only: [:create, :destroy]

  def create
    bookmark = Bookmark.new(user_id: current_user.id, shop_id: @shop.id)
    bookmark.save
    render 'shops/show'
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, shop_id: @shop.id)
    bookmark.destroy if bookmark.present?
    render 'shops/show'
  end

  private

    def set_shop
      @shop = Shop.find_by(id: params[:shop_id])
    end
end
