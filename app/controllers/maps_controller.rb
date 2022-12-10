class MapsController < ApplicationController
  helper_method :return_img_path

  def search
    @shops = Shop.all
    gon.shops = @shops
  end

  private
    def return_img_path(name)
      shop = Shop.find_by(name: name)
      if shop && shop.images.attached?
        shop.images.first
      else
        'no_image.png'
      end
    end
end
