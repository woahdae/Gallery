class UserMailer < ActionMailer::Base
  default from: Gallery.settings.mail_from

  # TODO: implement the view!
  def download_ready(order)
    @order = order

    mail(:to      => @order.user.email,
         :subject => "Your pictures are ready for download")
  end
end
