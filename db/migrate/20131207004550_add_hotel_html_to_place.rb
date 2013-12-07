class AddHotelHtmlToPlace < ActiveRecord::Migration
  def change
    add_column :places, :hotel_html, :text
  end
end
