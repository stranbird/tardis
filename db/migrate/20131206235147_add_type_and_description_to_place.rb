class AddTypeAndDescriptionToPlace < ActiveRecord::Migration
  def change
    add_column :places, :type, :string
    add_column :places, :description, :string
  end
end
