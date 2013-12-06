class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  attr_accessible :content, :title, :place_id, :user_id
end
