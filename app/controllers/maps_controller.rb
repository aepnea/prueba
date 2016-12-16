class MapsController < ApplicationController
  before_action :init_track_id
  before_filter :init_track_id

  def maps_view
    @id = params[:id]
    @data = Datum.where(track_id: @id)
    @center = Datum.where(track_id: @id).last
    @mark = Mark.new()
    @label = "caca"

  end

  def update

    @lat = params[:latlng][:latitude]
    @lon = params[:latlng][:longitude]
    logger.info " ##################################    #{@lat} #{@lon}"

    @mark_create = Mark.create([{lat: @lat, lon: @lon}])
    @mark_last = Mark.last
    @mark_last_id = @mark_last.id
  end


  def create
    @label = params[:mark][:label]
    @datum = params[:mark][:datum]


    logger.info " ##################################    #{@label} #{@lat} #{@lon}"

    @mark_last.update(label: @label, lat: @lat, lon: @lon)


    #if @mark.save

      redirect_to maps_maps_view_path(1)
      #render :json => { }
    #else
    #render :json => { }, :status => 500
    #end
  end


  def mark_params
    params.require(:mark).permit(:datum_id[], :label[])
  end

  def dist_params
    params.require(:latlng).permit(:latitude[], :longitude[])
  end
  def init_track_id
      @id = params[:id]
      return @id
  end
end
