class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  
  attr_accessible :content, :title, :place_id, :user_id

  include PublicActivity::Model
  tracked :owner => :user

  opinio_subjectum

  acts_as_votable
end
