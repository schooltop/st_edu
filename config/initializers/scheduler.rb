
require 'rubygems'
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '3h' do
  # do something every 3 hours
  # 目前創建的時候都不自动发邮件，在后台发，同时课程管理模块也有手动发邮件功能。
  StudentClassModule.start_modle_emails
  StudentChoiceCourse.start_course_emails
end 


scheduler.every '3s', :first => :now do
  n = Time.now; p [ :in, n, n.to_f ]
  Emailer.start_course_emails(recevier,subject, message).deliver
end



