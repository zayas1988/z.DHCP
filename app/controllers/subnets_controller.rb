class SubnetsController < ApplicationController
before_filter :signed_in_user

  def destroy
    Subnet.find(params[:id]).destroy
    flash[:success] = "Subnet destroyed."
    redirect_to subnets_url
  end

  def index
    @subnets = @subnets = Subnet.paginate(page: params[:page])
  end
  def show
    @subnets = Subnet.all
#    @hosts = @subnets.hosts.all
  end
 
  def new
   @subnet = Subnet.new
  end

  def create
    @subnet = Subnet.new(params[:subnet])
    if @subnet.save
#        sign_in @user
        flash[:success] = "Subnet added"
        redirect_to subnets_url
    else
      render 'new'
    end
  end

  def edit
   @subnet = Subnet.find(params[:id])
  end

  def update
   @subnet = Subnet.find(params[:id])
    if @subnet.update_attributes(params[:subnet])
      flash[:success] = "Subnet updated"
      redirect_to subnets_url
    else
      render 'edit'
    end
  end

  def getfreeips
    @freeips=Subnet.find_by_id(params[:id]).freeips
    render layout: false
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
