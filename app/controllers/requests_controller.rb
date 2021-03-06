class RequestsController < ApplicationController
  before_filter :authenticate

  def create
    @ad = Ad.find(params[:request][:ad_id])
    r = current_user.request!(params[:request])
    AppMailer.notify_request_mail(r).deliver
    @ad.user.add_notification
    redirect_to @ad
  end

  def destroy
    @ad = Request.find(params[:id]).ad
    current_user.remove_request(@ad.id)
    redirect_to @ad
  end

end
