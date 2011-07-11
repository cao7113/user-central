class AccessGrant < ActiveRecord::Base
  belongs_to :user
  belongs_to :client_app, :foreign_key => "client_id"
  before_create :generate_tokens


  class << self
    def prune!
      #三天有效？
      delete_all(["created_at < ?", 3.days.ago])
    end
  
    def authenticate(code, application_id)
      where("code = ? AND client_id = ?", code, application_id).first
    end
  end

  def generate_tokens
    self.code, self.access_token, self.refresh_token = 
       SecureRandom.hex(16), SecureRandom.hex(16), SecureRandom.hex(16)
  end

  def redirect_uri_for(redirect_uri)
    redirect_uri+(redirect_uri =~ /\?/ ? "&" :"?")+"code=#{code}&response_type=code"
  end

  # Note: This is currently hard coded to 2 days, but it could be configurable 
  # per-user-type or per-application.
  # No need for this to be constant like this.
  # FIXME
  def start_expiry_period!
    self.update_attribute(:access_token_expires_at, 2.days.from_now)
  end
end
