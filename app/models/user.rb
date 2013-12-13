require "digest/sha2"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :hashed_password, :name, :salt
  validates :email,  :presence => true, :uniqueness => true
  validates :password, :confirmation => true
  #attr_accessor :password_confirmation
  #attr_reader :password
  #validate :password_must_be_present

  #调用gratastic头像
  include Gravtastic
  gravtastic

  has_many :user_tags
  has_many :tags, :through => :user_tags
end
