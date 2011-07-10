=begin
  FIXME： 管理资源的访问控制问题！！！
=end

class ClientAppsController < ApplicationController
  
  before_filter :authenticate_user!
  #TODO 需要有部分权限验证的，要不修改了不是自己的资源怎么办？？？
  
  def index
    @client_apps=current_user.client_apps.paginate :all, :page=>params[:page], :order=>"updated_at desc"
  end

    # GET /seeds/new
  # GET /seeds/new.xml
  def new
    @client_app = ClientApp.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seed }
    end
  end

  # GET /seeds/1/edit
  def edit
    @client_app = ClientApp.find(params[:id])
  end
  
  def create
    client_app=ClientApp.create(:name=>params[:name].to_s.strip, :user_id=>current_user.id)
    flash[:notice]="#{client_app.name} has created!"
    redirect_to :action=>:index
  end

  # PUT /client_apps/1
  # PUT /client_apps/1.xml
  def update
    @client_app = ClientApp.find(params[:id])

    respond_to do |format|
      if @client_app.update_attributes(params[:client_app])
        format.html { redirect_to(client_apps_path, :notice => 'Client app was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seed.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    ClientApp.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to(client_apps_url, 
                     :notice => 'The client app is deleted!') }
      format.xml  { head :ok }
    end
  end

end
