class AppMailer < ActionMailer::Base
  default from: "wwwdesignproject@gmail.com"
  def notify_request_mail(request)
    @request = request
    mail(:to => "#{request.ad.user.name} <#{request.ad.user.email}>", :subject => "New Request")
  end
end
