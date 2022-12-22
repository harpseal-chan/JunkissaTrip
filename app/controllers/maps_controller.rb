class MapsController < ApplicationController
  def search
    @shops = Shop.all
    gon.shops = @shops
  end
end
