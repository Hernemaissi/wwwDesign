# encoding: UTF-8

class AdsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :new, :edit, :update, :toggle_available]

  def index
    @title = "All ads"
    @ads = Ad.all
  end
  
  
  def show
    @title = "Temp title"
    @ad = Ad.find(params[:id])
    respond_to do |format|
        format.html
        format.js
    end
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "Uusi ilmoitus lisätty"
      redirect_to @ad
    else
      @title = "Post new ad"
      render 'new'
    end
  end

  def destroy
  end

  def edit
    @ad = Ad.find(params[:id])
  end

  def update
    #part_id checkboxes
    params[:ad][:part_ids] ||= []
    
    @ad = Ad.find(params[:id])
    if @ad.update_attributes(params[:ad])
      flash[:notice] = "Successfully updated ad."
      redirect_to @ad
    else
      render :action => 'edit'
    end
  end    

  def new
    @ad = Ad.new
    @title = "Post new ad"
  end
  
  def toggle_available
     @ad = Ad.find(params[:id])
     if current_user?(@ad.user) && request.post?
       @ad.available = (@ad.available?) ? false : true
       @ad.save
       respond_to do |format|
         format.html { redirect_to @ad, :success => "Availability toggled" }
         format.js
       end
     else
       redirect_to root_path
     end
  end
  
  
end
