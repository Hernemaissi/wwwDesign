class AdsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :new, :edit, :update, :toggle_available]

  def index
    @title = "All ads"
    @ads = Ad.all
  end
  
  def show
    @title = "Temp title"
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = current_user.ads.build(params[:ad])
    if @ad.save
      flash[:success] = "New ad posted"
      redirect_to @ad
    else
      @title = "Post new ad"
      render 'new'
    end
  end

  def destroy
  end

  def edit
  end

  def update
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
       flash[:success] = "Availability toggled"
       redirect_to @ad
     else
       redirect_to root_path
     end
  end

end