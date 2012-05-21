# encoding: UTF-8

class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  before_filter :logged_in,    :only => [:new, :create]
  
  def index
    @title = "Kaikki käyttäjät"
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    if current_user?(@user)
      @user.reset_notifications
    end
  end
  
  def new
    @user = User.new
    @title = "Kirjaudu sisään"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Tervetuloa!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Muokkaa profiilia"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profiili päivitetty."
      redirect_to @user
    else
      @title = "Muokkaa profiilia"
      render 'edit'
    end
  end
  
  def destroy
    des_user = User.find(params[:id])
    if !current_user?(des_user)
      des_user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    else
      flash[:error] = "Can't destroy yourself."
      redirect_to users_path
    end
  end
  
   private
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def logged_in
      redirect_to(root_path) unless !signed_in?
    end
    

end
