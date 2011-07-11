=begin
  客户端应用
=end

class ClientApp < ActiveRecord::Base
  
  belongs_to :user
  before_create :generate_tokens
  
  class << self    
    def authenticate(app_id, app_secret)
      where(["app_id = ? AND app_secret = ?", app_id, app_secret]).first
    end
  end
  
  #是否能保证唯一性
  def generate_tokens
    self.app_id, self.app_secret = 
       SecureRandom.hex(16), SecureRandom.hex(16)
  end
  
  def to_s
    "Client App #{name}: #{app_id}-#{app_secret}"
  end
end
