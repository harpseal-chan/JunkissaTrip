class MapsController < ApplicationController
  def search
    default_lat = 35.681236
    default_lng = 139.767125
    gon.lat = default_lat
    gon.lng = default_lng
  end
end
