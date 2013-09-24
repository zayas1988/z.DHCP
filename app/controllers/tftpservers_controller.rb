class TftpserversController < ApplicationController
before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  def new
  @tftpserver = Tftpserver.new
  end
  def create
  	@tftpserver = Tftpserver.new(params[:tftpserver])
  	if @tftpserver.save
  	  flash[:success] = "Tftpserver added"
  	  redirect_to main_path
  	else
  		 render :adction => :new
    end
  end
  def edit
   	@tftpserver = Tftpserver.find(params[:id])
  end
  def update
  	if @tftpserver.update_attributes(params[:tftpserver])
      flash[:success] = "Tftpserver updated"
      redirect_to main_path
    else
      render :action => :edit
    end
  end
  def destroy
  	Tftpserver.find(params[:id]).destroy
  	flash[:success] = "Tftpserver deleted"
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
