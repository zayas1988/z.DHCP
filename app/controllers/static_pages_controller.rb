class StaticPagesController < ApplicationController
  def home
   
  end

  def help
  end
  def about
  end
  def configure
   @users = @users = User.paginate(page: params[:page])
   @subnets = @subnets = Subnet.paginate(page: params[:page])
   @tftps = @tftps = Tftp.paginate(page: params[:page])
  end
  def show_users
    redirect_to :controller => 'users', :action => 'index'
  end

end
