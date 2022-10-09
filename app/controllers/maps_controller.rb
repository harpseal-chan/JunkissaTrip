class MapsController < ApplicationController
  def search    
    if params[:lat_lng]
      gon.lat = geo_params[:latitude].to_f
      gon.lng = geo_params[:longitude].to_f
    else
      default_lat = 35.681236
      default_lng = 139.767125
      gon.lat = default_lat
      gon.lng = default_lng
    end
    radius = 1.0
    gon.shops = Shop.all.within(radius, :origin => [gon.lat, gon.lng])
  end

  private
    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end
end
