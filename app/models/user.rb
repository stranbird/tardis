class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  has_private_messages

  acts_as_followable
  acts_as_follower

  acts_as_voter

  has_many :reviews

  opinio_subjectum

  acts_as_marker

  has_many :places

  alias_method :added_places, :places

  def latest_activity
    PublicActivity::Activity.where(:owner_id => id).order(:id).last
  end

end
