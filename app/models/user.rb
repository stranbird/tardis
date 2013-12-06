class User < ActiveRecord::Base
  # attr_accessible :title, :body

  has_private_messages
end
