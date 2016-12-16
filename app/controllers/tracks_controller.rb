class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]


  def index
    @tracks = Track.all
  end


  def show
  end


  def new
    @track = Track.new
  end


  def edit
  end


  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        ### Tomando el ultimo registro guardado
        f = Track.last
        ### Tomando el ID
        trackid = f.id
        ### path del archivo gpx
        path = f.gpx.path
        ### Abriendo archivo gpx
        doc = Nokogiri::XML(File.open(path))
        ### sacando <name> y guardando
        name = doc.xpath('//xmlns:name/text()').map{|pt| pt.to_s}
        f.update(track: name)

        ### tomando lon, lat, ele y time
        x = doc.xpath('//xmlns:trkpt/@lon').map{|pt| pt.to_s.to_f}
        y = doc.xpath('//xmlns:trkpt/@lat').map{|pt| pt.to_s.to_f}
        e = doc.xpath('//xmlns:ele/text()').map{|pt| pt.to_s.to_f}
        t = doc.xpath('//xmlns:time/text()').map{|pt| pt.to_s}

        ### grabando en Datum
        $i = 0
        $num = x.count

        while $i < $num  do
          Datum.create([{track_id: trackid, lon: x[$i], lat: y[$i], ele: e[$i], time: t[$i]}])
          $i +=1
        end
        ### Obteniendo/registrando inicio/fin de carrera
        time_begin = Datum.where(track_id: f.id).first
        time_end = Datum.where(track_id: f.id).last
        ### obteniendo la diferencia de tiempo
        ### validando formato extraño de gpx
        if time_end.time.blank?
          logger.info "Archivo no tiene recurrencia de fecha"
        else
          time_elapsed = TimeDifference.between(time_begin.time, time_end.time).humanize
        end
        ### su registro loco en el log
        logger.info "time_begin: #{time_begin.time} time_end: #{time_end.time} #{time_elapsed} "
        ### guardando datos
        f.update(time_begin: time_begin.time, time_end: time_end.time, time_elapsed: time_elapsed)




        format.html { redirect_to @track, notice: 'Carrera creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_track
      @track = Track.find(params[:id])
    end

    def track_params
      params.require(:track).permit(:track, :gpx, :gpx_content_type, :gpx_file_size, :gpx_updated_at, :time_begin, :time_end, :time_elapsed)
    end
end
