class AddPicAndLatLngToPlace < ActiveRecord::Migration
  def change
    add_column :places, :pic, :string
    add_column :places, :latitude, :string
    add_column :places, :longitude, :string
  end
end
