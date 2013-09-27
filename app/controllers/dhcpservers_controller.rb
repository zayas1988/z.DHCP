class DhcpserversController < ApplicationController
before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  def index
    
        #@hosts = @hosts = Host.paginate(page: params[:page])
    #@hosts= Host.all
  end

  def new
  @dhcpserver = Dhcpserver.new
  end
  def create
  	@dhcpserver = Dhcpserver.new(params[:dhcpserver])
  	if @dhcpserver.save
  	  flash[:success] = "Dhcpserver added"
  	  redirect_to main_path
  	else
  		 render :adction => :new
    end
  end
  def edit
   	@dhcpserver = Dhcpserver.find(params[:id])
  end
  def update
  	@dhcpserver = Dhcpserver.find(params[:id])
    
    if @dhcpserver.update_attributes(params[:dhcpserver])
      if @dhcpserver.lock = true
        @tftps = Tftp.all
        @dhcpserver.generate_config
        @dhcpserver.update_attributes(params[lock=false])
      end
      flash[:success] = "Dhcpserver updated"
      redirect_to main_path
    else
      render :action => :edit
    end
  end
  def destroy
  	Dhcpserver.find(params[:id]).destroy
  	flash[:success] = "Dhcpserver deleted"
  	redirect_to main_path
  end
  def reconfigure
    @dhcpserver = Dhcpserver.first

    #Dhcpserver.generate_config
  end
 
  private
 
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end
