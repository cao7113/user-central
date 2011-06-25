class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :dev?, :local_test?
  
  def dev?
    Rails.env.development?
  end
  
  def local_test?
    request.local?
  end
end
