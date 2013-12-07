class AddMapToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :map_html, :text
  end
end
