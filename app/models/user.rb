class User < ActiveRecord::Base
  has_many :authentications, :dependent => :delete_all
  has_many :access_grants, :dependent => :delete_all

  before_validation :initialize_fields, :on => :create

  devise :database_authenticatable, :registerable, :token_authenticatable,
         :recoverable, :timeoutable, :trackable, :validatable, :rememberable

  self.token_authentication_key = "access_token"

  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name,
                  :username, :home_url
                  
  validates_presence_of :username               
  validates_uniqueness_of :username
  
  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def self.omniauth_hash(omniauth)
    #注入新的用户信息
    {:username=>omniauth['user_info']['username'],
     :email=> omniauth['user_info']['email'] ,
     :home_url=>omniauth['user_info']['home_url']}
  end

  def self.find_for_token_authentication(conditions)
    where(["access_grants.access_token = ? AND (access_grants.access_token_expires_at IS NULL OR access_grants.access_token_expires_at > ?)", 
                               conditions[token_authentication_key],                                                  Time.now]).
    joins(:access_grants).
    select("users.*").
    first
  end
  
  def initialize_fields
    self.status = "Active"
    #FIXME cancel this
    self.expiration_date = 1.year.from_now
  end
end
