class AddTicketHtmlToPlace < ActiveRecord::Migration
  def change
    add_column :places, :ticket_html, :text
  end
end
