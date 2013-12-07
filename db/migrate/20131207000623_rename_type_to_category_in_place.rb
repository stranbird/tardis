class RenameTypeToCategoryInPlace < ActiveRecord::Migration
  def change
    rename_column :places, :type, :category

  end
end
