class Place < ActiveRecord::Base
  attr_accessible :name, :longitude, :latitude, :category, :description, :pic
  attr_accessible :ticket_html, :hotel_html, :map_html
  belongs_to :user

  markable_as :visited

  include PublicActivity::Model
  tracked :owner => :user

  has_many :reviews
end
