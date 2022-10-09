class MapsController < ApplicationController
  def search    
    if params[:lat_lng]
      @latitude = geo_params[:latitude].to_f
      @longitude = geo_params[:longitude].to_f
      gon.lat = @latitude
      gon.lng = @longitude
      @flag = 1
    else
      @flag = 0
      default_lat = 35.681236
      default_lng = 139.767125
      gon.lat = default_lat
      gon.lng = default_lng
    end
    radius = 1.0
    @shops = Shop.all.within(radius, :origin => [gon.lat, gon.lng])
    gon.shops = @shops
  end

  private
    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end
end
