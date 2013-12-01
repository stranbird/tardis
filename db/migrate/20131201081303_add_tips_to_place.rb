class AddTipsToPlace < ActiveRecord::Migration
  def change
    add_column :places, :tips, :text
  end
end
