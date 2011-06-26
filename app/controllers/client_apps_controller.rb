=begin
  FIXME： 管理资源的访问控制问题！！！
=end

class ClientAppsController < ApplicationController
  def index
    @clients=Client.paginate :all, :page=>params[:page], :order=>"updated_at desc"
  end
  
  def create
    client=Client.create(:name=>params[:name].to_s.strip)
    flash[:notice]="#{client.name} has created!"
    redirect_to :action=>:index
  end
  
  def destroy
    Client.destroy(params[:id])

    respond_to do |format|
      format.html { redirect_to(client_apps_url, 
                     :notice => 'The client is deleted!') }
      format.xml  { head :ok }
    end
  end

end
