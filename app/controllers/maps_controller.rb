class MapsController < ApplicationController
  before_action :set_track_id


  def maps_view
    # Tomando variables

    @id = params[:id]

    # Cargando data para la vista map_view

    @data = Datum.where(track_id: @id)
    @center = Datum.where(track_id: @id).last

    # cargando datos para los markers
    @markers = Mark.where(track_id: @id)

  end

  def create
    # Tomando variables
    @lat = params[:latlng][:latitude]
    @lon = params[:latlng][:longitude]
    @track_id = params[:latlng][:track_id]

    # logueando para hacer un checkpoint
    logger.info " ##################################  Creando Marker  #{@lat} #{@lon} #{@track_id}"

    @mark_create = Mark.create([{lat: @lat, lon: @lon, track_id: @track_id}])

    # redirigiendo para maps_view
    redirect_to maps_maps_view_path(@track_id)

  end

  def destroy
    track_id = params[:track_id]
    Mark.destroy(params[:id])
 ### redirigiendo de vuelta al mapa
    redirect_to maps_maps_view_path(track_id)
  end


  def dist_params
    params.require(:latlng).permit(:latitude[], :longitude[])
  end
  def set_track_id
      @track = params[:id]
  end
end
