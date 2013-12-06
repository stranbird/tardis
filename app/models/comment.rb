class Comment < ActiveRecord::Base
  opinio

  include PublicActivity::Model
  tracked :owner => :owner
end
