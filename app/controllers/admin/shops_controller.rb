class Admin::ShopsController < ApplicationController
  def index
    @shops = Shop.all
  end
end
