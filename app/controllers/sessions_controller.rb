# encoding: UTF-8

class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate_user(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Virheellinen sähköpostiosoite tai salasana"
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or root_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def change_gender
    cookies.permanent.signed[:gender] = params[:gender]
    @categories = Category.find_by_name(params[:gender]).children
    @current_gender = params[:gender]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
end
