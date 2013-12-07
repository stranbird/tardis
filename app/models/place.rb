class Place < ActiveRecord::Base
  attr_accessible :name, :longitude, :latitude, :category, :description, :pic
  belongs_to :user

  markable_as :visited

  include PublicActivity::Model
  tracked :owner => :user

  has_many :reviews
end
