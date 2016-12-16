class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.integer :track_id
      t.decimal :lat, :precision => 11, :scale => 7
      t.decimal :lon, :precision => 11, :scale => 7
      t.string :label

      t.timestamps null: false
    end
  end
end
