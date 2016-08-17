class Emailer < ApplicationMailer

  # 开启模块通知
  def start_modle_emails(recevier,subject, message)
    mail(:to=> "jamst.li@whmall.com" ,:subject => "网化商城代销寄售产品库存预警 #{search_date.to_s(:db)} TO #{email}")
  end

  # 开启选课通知
  def start_course_emails(recevier,subject, message)
    mail(:to=> "jamst.li@whmall.com" ,:subject => "网化商城代销寄售产品库存预警 #{search_date.to_s(:db)} TO #{email}")
  end

  # 释放选课通知
  def relest_record_notice(recevier,subject, message)
    mail(:to=> "jamst.li@whmall.com" ,:subject => "网化商城代销寄售产品库存预警 #{search_date.to_s(:db)} TO #{email}")
  end

end
