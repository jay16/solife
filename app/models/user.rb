require "digest/sha2"
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :hashed_password, :salt
  attr_accessible :ruler, :created_at
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

  #has_many :user_consumes
  #has_many :consumes , :through => :user_consumes
  has_many :consumes

  def is_admin?; chk_ruler(0); end
  def is_consume?; chk_ruler(1); end

  def friend_consumes(consume_id)
    Consume.where("user_id <> #{self.id} and id > #{consume_id}")
  end

  def find_user_with_api_token token
    api_token == Digest::MD5.hexdigest(self.email+self.password) 
  end

  private

  def chk_ruler(n)
    self.update_attribute(:ruler,"000000000000000") if self.ruler.nil?
    return self.ruler[n] == "1"
  end

  def api_authen(api_token = "")
    api_token == Digest::MD5.hexdigest(self.email+self.password)
  end

end
