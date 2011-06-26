class RegistrationsController < Devise::RegistrationsController
  #before_filter :save_referrer, :only => :edit 

  def new     
     # Building the resource with information that MAY BE available from omniauth!
     hash=session[:omniauth] ? User.omniauth_hash(session[:omniauth]) : {}
     build_resource(hash)
     render_with_scope :new
  end

  def create    
    build_resource 
    if session[:omniauth] && @user.errors[:email][0] =~ /has already been taken/
      user = User.find_by_email(@user.email)
      # Link Accounts - if via social connect
      return redirect_to link_accounts_url(user.id)
    end

    # normal processing
    super
    session[:omniauth] = nil unless @user.new_record?
  end
  
  def build_resource(*args)        
    super         
    if session[:omniauth]
      #build_resource后会定义一个实例变量 @#{resource_name}
      @user.apply_omniauth(session[:omniauth])      
      #execute validation check and give some error hint!
      @user.valid?
    end
  end

  def after_update_path_for(scope)
    session[:referrer] ? session[:referrer] : root_path
  end
end
