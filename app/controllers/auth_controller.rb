=begin
  应用授权控制
=end

class AuthController < ApplicationController
  before_filter :authenticate_user!, :except => [:access_token]
  
  #在哪儿定义的？ Module ActionController::RequestForgeryProtection
  skip_before_filter :verify_authenticity_token, :only => [:access_token]

  def authorize
    #记下该用户登录的应用
    if application 
      (session[:login_clients]||=[])<<application.id
    end
    AccessGrant.prune!
    access_grant = current_user.access_grants.create(:client_app => application)
    redirect_to access_grant.redirect_uri_for(params[:redirect_uri])
  end

  def access_token
    application = ClientApp.authenticate(params[:client_id], params[:client_secret])
    
    if application.nil?
      render :json => {:error => "Could not find application"}
      return
    end
    
    access_grant = AccessGrant.authenticate(params[:code], application.id)
    if access_grant.nil?
      render :json => {:error => "Could not authenticate access code"}
      return
    end
    
    access_grant.start_expiry_period!
    render :json => {:access_token => access_grant.access_token, :refresh_token => access_grant.refresh_token, :expires_in => Devise.timeout_in.to_i}
  end

  def failure
    render :text => "ERROR: #{params[:message]}"
  end

  def user
    hash = {
      :provider => UC_PROVIDER_NAME,
      :uid => current_user.id.to_s,
      :user_info => {
         :name => current_user.username,
         :email=> current_user.email
      },
      :extra => {
        :admin => current_user.admin?,
        :home_url=>current_user.home_url
      }
    }

    render :json => hash.to_json
  end

  #TODO 什么个意思啊？？？
  # Incase, we need to check timeout of the session from a different application!
  # This will be called ONLY if the user is authenticated and token is valid
  # Extend the UserManager session 
  def isalive
    warden.set_user(current_user, :scope => :user)
    response = { 'status' => 'ok' }

    respond_to do |format| 
      format.any { render :json => response.to_json }
    end
  end

  protected

  def application
    @application ||= ClientApp.find_by_app_id(params[:client_id])
    raise "No appropriate app for app_id=#{params[:client_id]}" if @application.nil?
    @application
  end

end
