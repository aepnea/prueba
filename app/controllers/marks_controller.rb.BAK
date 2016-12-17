class MarksController < ApplicationController
  def create
    logger.info " ###################################{params[:lat]}"
    @mark = Mark.new params[mark_params]

    if @mark.save

      redirect_to maps_maps_view_path(1)
      #render :json => { }
    else
    render :json => { }, :status => 500
    end
  end

  def mark_params
    params.require(:mark).permit(:track_id, :label, :lat, :lon)
  end
end
