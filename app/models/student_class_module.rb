class StudentClassModule < ActiveRecord::Base
	
	# DROP TABLE IF EXISTS `student_class_modules`;
	# CREATE TABLE `student_class_modules` (
	#   `id` int(11) NOT NULL AUTO_INCREMENT,
	#   `name` varchar(255) DEFAULT NULL,
	#   `student_class_id` int(11) DEFAULT NULL COMMENT '主班级',
	#   `course_ids` varchar(255) DEFAULT NULL COMMENT '包含的课程',
	#   `state` varchar(255) DEFAULT NULL COMMENT '状态',
	#   `student_class_type` varchar(25) DEFAULT NULL COMMENT '班级类型MBA/EMBA',
	#   `search_type` varchar(255) DEFAULT NULL COMMENT '选课类型 :  	必修、选修、大通选、旁听',
	#   `term` varchar(255) DEFAULT NULL COMMENT '学期',
	#   `created_at` datetime DEFAULT NULL,
	#   `updated_at` datetime DEFAULT NULL,
	#   `create_user_id` int(11) DEFAULT NULL COMMENT '模块创建者',
	#   start_time
	#   end_time
	#   PRIMARY KEY (`id`)
	# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	has_many :student_choice_courses
	has_many :student_choice_classes
	has_many :student_course_records


	# # 定时开启选课
 #    def self.start_choice_modles
 #      StudentClassModule.find(:all,:conditions=>"state = 0 and start_time = #{Time.now.beginning_of_day}").each do |choice_modles|
 #        choice_modles.state = 1
 #        choice_modles.module_notice
 #        choice_modles.had_email = 1
 #        choice_modles.save
 #      end
 #    end

    # 定时发送邮件(非定时自动开启的情况)
    def self.start_modle_emails
      StudentClassModule.find(:all,:conditions=>"state = 1 and had_email != 1  and start_time = #{Time.now.beginning_of_day}").each do |choice_modles|
        choice_modles.module_notice
        choice_modles.had_email = 1
        choice_modles.save
      end
    end

	# 具体谁上什么课选课也知道了!
	def module_notice
      mail_temple = MailTemplate.find(:last,:conditions=>"1=1")
	  self.student_course_records.each do |record|
	  	recevier = record.stu_reg_inf.emial
	  	message = mail_temple.contect
	  	subject = "选课通知"
	    Emailer.start_modle_emails(recevier,subject, message).deliver
      end
	end

end