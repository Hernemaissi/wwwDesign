class AdsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy, :new, :edit, :update]

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
      render 'pages/home'
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

end
