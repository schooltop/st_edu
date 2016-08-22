class Emailer < ApplicationMailer

  # 开启模块通知
  def start_modle_emails(recevier,subject, message)
    @message = message
    @subject = subject
    @recevier = recevier
    mail(:to=> "jamst.li@whmall.com" ,:subject => subject )
  end

  # 开启选课通知
  def start_course_emails(recevier,subject, message)
    @message = message
    @subject = subject
    @recevier = recevier
    mail(:to=> "jamst.li@whmall.com" ,:subject => subject )
  end

  # 释放选课通知
  def relest_record_notice(recevier,subject, message)
    @message = message
    @subject = subject
    @recevier = recevier
    mail(:to=> "jamst.li@whmall.com" ,:subject => subject )
  end

end
