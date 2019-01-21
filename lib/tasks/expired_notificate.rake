namespace :expired_notificate do
  desc "try patch"
  task push_mail: :environment do
    # set class and tasks
    mailer = NotificateMailer
    target_tasks = Task.expired_task_all(ENV['EXPIRED_DAY'])

    # send mail in each task
    target_tasks.each do |task|
      send_mail(mailer, task)
    end
  end

  def send_mail(mailer, task)
    puts "------------"
    puts "send task: #{task.title}"
    mailer.notificate_mail(task).deliver
  end
end

