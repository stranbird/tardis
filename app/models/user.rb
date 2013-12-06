class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_private_messages

  acts_as_followable
  acts_as_follower

  acts_as_voter

  has_many :reviews

  opinio_subjectum

  acts_as_marker

  def name
    email
  end
end
