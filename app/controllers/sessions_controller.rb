class SessionsController < Devise::SessionsController
  # GET /resource/sign_out
  def destroy
    return if in_turn_redirect_logout_clients
    signed_in = signed_in?(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_in
    
    # We actually need to hardcode this, as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
      format.all do
        method = "to_#{request_format}"
        text = {}.respond_to?(method) ? {}.send(method) : ""
        render :text => text, :status => :ok
      end
    end
  end
  
  #通知各客户应用退出，TODO 时效性！
  def in_turn_redirect_logout_clients
    return false if session[:login_clients].blank?
    session[:login_clients]||=[]
    if params['client_id']
      client=ClientApp.find_by_app_id(params['client_id'])
      session[:login_clients].delete(client.id) if client
    end
    next_client_id=session[:login_clients].first
    if next_client_id
      next_client=ClientApp.find(next_client_id)
      logger.debug "====redirect to #{next_client.name} #{next_client.logout_url} for logout..."
      redirect_to next_client.logout_url  
      return true         
    end
    false
  end
end

