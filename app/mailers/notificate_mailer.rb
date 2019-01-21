class NotificateMailer < ApplicationMailer
  def notificate_mail(expired_task)
    @expired_task = expired_task

    mail to: "example@gmail.com", subject: "期限切れタスクの通知"
  end
end
