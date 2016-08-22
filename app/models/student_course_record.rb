class StudentCourseRecord < ActiveRecord::Base

	# DROP TABLE IF EXISTS `student_course_records`;
	# CREATE TABLE `student_course_records` (
	#   `id` int(11) NOT NULL AUTO_INCREMENT,
	#   `student_choice_course_id` int(11) DEFAULT NULL COMMENT '迁移的时候关联',
	#   `stu_reg_inf_id` int(11) DEFAULT NULL COMMENT '学生id',
	#   `student_class_id` int(11) DEFAULT NULL COMMENT '迁移班级',
	#   `course_id` int(11) DEFAULT NULL,
	#   `scor` int(11) DEFAULT NULL,
	#   `weight` int(11) DEFAULT NULL,
	#   `state` int(11) DEFAULT NULL COMMENT '状态', 0激活，1已迁移，2已删除
	#   `course_type` int(11) DEFAULT NULL COMMENT '必修、选修',
	#   `scor_or_weight` int(11) DEFAULT NULL COMMENT '分数or权重',
	#   status "0已开放，1未开放"
	#   student_class_module_id
	#   student_choice_class_id
	#   `train_plan_id` int(11) DEFAULT NULL COMMENT '关联培养方案',
	#   PRIMARY KEY (`id`)
	# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	belongs_to :stu_reg_inf
	belongs_to :student_choice_course
	belongs_to :student_choice_class
	belongs_to :student_class_module

	# 释放选课通知
    def self.relest_record_notice
      #状态为2的是释放状态，已发送通知邮件的话 had_email ＝ 1
      StudentCourseRecord.find(:all,:conditions=>"state = 2 and had_email != 1 ").each do |record|
	    mail_temple = MailTemplate.find(:last,:conditions=>"1=1")
        recevier = record.stu_reg_inf.email
        message = mail_temple.content
        subject = "取消选课通知"
        record.had_email = 1
        record.save
        Emailer.relest_record_notice(recevier,subject, message).deliver
      end
    end
	
end