class RequestsController < ApplicationController
  before_filter :authenticate

  def create
    @ad = Ad.find(params[:request][:ad_id])
    current_user.request!(params[:request])
    @ad.user.add_notification
    redirect_to @ad
  end

  def destroy
    @ad = Request.find(params[:id]).ad
    current_user.remove_request(@ad.id)
    redirect_to @ad
  end

end
