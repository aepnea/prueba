class MapsController < ApplicationController
  def maps_view
    @id = params[:id]
    @data = Datum.where(track_id: @id)
    @center = Datum.where(track_id: @id).last
  end
end
