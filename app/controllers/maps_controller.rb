class MapsController < ApplicationController
  def search
    if params[:lat_lng]
      gon.lat = geo_params[:latitude].to_f
      gon.lng = geo_params[:longitude].to_f
    else
      # default lat_lng
      gon.lat = 35.681236
      gon.lng = 139.767125
    end
    radius = 1.5
    @shops = Shop.all.within(radius, origin: [gon.lat, gon.lng]).by_distance(origin: [gon.lat, gon.lng]).preload(:features, images_attachments: :blob)
    gon.shops = @shops
  end

  private

    def geo_params
      params.require(:lat_lng).permit(:latitude, :longitude)
    end
end
