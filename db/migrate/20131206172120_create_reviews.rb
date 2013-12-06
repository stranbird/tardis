class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.references :place
      t.references :user

      t.timestamps
    end
    add_index :reviews, :place_id
    add_index :reviews, :user_id
  end
end
