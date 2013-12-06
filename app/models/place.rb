class Place < ActiveRecord::Base
  attr_accessible :name

  markable_as :visited

  include PublicActivity::Model
  tracked :owner => :user

  has_many :reviews
end
