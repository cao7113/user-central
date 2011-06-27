class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :dev?, :local_run?, :auth_from
  
  def dev?
    Rails.env.development?
  end
  
  def local_run?
    request.local?
  end
  
  def auth_from(provider)
    #由omniauth的middleware拦截处理
    raise "Missing provider!" if provider.blank?
    "/auth/#{provider}"
  end
end
