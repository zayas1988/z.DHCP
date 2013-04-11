class TftpsController < ApplicationController
before_filter :signed_in_user

  def destroy
    Tftp.find(params[:id]).destroy
    flash[:success] = "Tftp group destroyed."
    redirect_to tftps_url
  end

  def index
    @tftps = @tftps = Tftp.paginate(page: params[:page])
  end

  def new
   @tftp = Tftp.new
  end

  def create
    @tftp = Tftp.new(params[:tftp])
    if @tftp.save
        flash[:success] = "Tftp group added"
        redirect_to tftps_url
    else
      render 'new'
    end
  end

  def edit
   @tftp = Tftp.find(params[:id])
  end

  def update
   @tftp = Tftp.find(params[:id])
    if @tftp.update_attributes(params[:tftp])
      flash[:success] = "Tftp group updated"
      redirect_to tftps_url
    else
      render 'edit'
    end
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end
