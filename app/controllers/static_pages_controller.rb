class StaticPagesController < ApplicationController
  def home
   
  end

  def help
  end
  def about
  end
  def configure
   @users = User.paginate(page: params[:page])
   @subnets = Subnet.paginate(page: params[:page])
   @tftps = Tftp.paginate(page: params[:page])
   end
  def show_users
    redirect_to :controller => 'users', :action => 'index'
  end
  def main
    #@subnets = Subnet.paginate(page: params[:page])
    @subnets = Subnet.all
    #@tftps = Tftp.paginate(page: params[:page])
    #@hosts = Host.paginate(page: params[:page])
    #@hosts = host.paginate(page: params[:page])
    #@hosts = Host.all
  end
end