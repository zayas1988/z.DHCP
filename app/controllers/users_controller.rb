class UsersController < ApplicationController

before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
#before_filter :correct_user,  only: [:edit, :update]
before_filter :admin_user, only: [:destroy, :edit, :update]

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def index
    @users = @users = User.paginate(page: params[:page])
  end

  def new
   @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
        flash[:success] = "User added"
        redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
   @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "User updated"
      redirect_to users_path
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
  def admin_user
      redirect_to(main_path) unless current_user.admin?
  end
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end
end
