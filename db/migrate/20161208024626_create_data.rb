class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer :track_id
      t.decimal :lat, :precision => 11, :scale => 7
      t.decimal :lon, :precision => 11, :scale => 7
      t.decimal :ele, :precision => 11, :scale => 1
      t.datetime :time

      t.timestamps null: false
    end
  end
end
