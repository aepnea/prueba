class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :track
      t.datetime :time_begin
      t.datetime :time_end
      t.string :time_elapsed
      t.timestamps null: false
    end
    ## para atachar archivo
    add_attachment :tracks, :gpx

  end
end
