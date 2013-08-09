class HostsController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @subnets = Subnet.all
    @tftps = Tftp.all
    #@hosts = @hosts = Host.paginate(page: params[:page])
    #@hosts= Host.all
  end

  def new
   @host = Host.new
   @subnets = Subnet.all
   @tftps = Tftp.all
  end

  def create
    @host = Host.new(params[:host])
    @subnets = Subnet.all
    @tftps = Tftp.all
    if @host.save
        flash[:success] = "Host added"
        redirect_to main_path
    else
      render :action => :new
    end
  end

  def edit
   @host = Host.find(params[:id])
   @subnets= Subnet.all
   @tftps= Tftp.all
  end
  def update
    @subnets= Subnet.all
   @tftps= Tftp.all
    @host = Host.find(params[:id])
    if @host.update_attributes(params[:host])
      flash[:success] = "Host updated"
      redirect_to main_path
    else
      render :action => :edit
    end
  end
  def destroy
    Host.find(params[:id]).destroy
    flash[:success] = "Host deleted."
    redirect_to main_path
  end
  private
 
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
