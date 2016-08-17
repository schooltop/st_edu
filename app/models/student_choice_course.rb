class StudentChoiceCourse < ActiveRecord::Base
	belongs_to :student_class_module
    has_many :student_choice_classes
    has_many :student_course_records
    belongs_to :student_class

    # # 定时开启选课(如果手动触发过的,状态变为state = 1了就不会再触发)
    # def self.start_choice_course
    #   StudentChoiceCourse.find(:all,:conditions=>"state = 0 and start_time = #{Time.now.beginning_of_day}").each do |choice_course|
    #     choice_course.state = 1
    #     choice_course.init_student_course_records
    #     choice_course.record_notice
    #     choice_course.had_email = 1
    #     choice_course.save
    #   end
    # end

    # 定时发送手动开启邮件
    def self.start_course_emails
	  StudentChoiceCourse.find(:all,:conditions=>"state = 1 and had_email != 1  and start_time = #{Time.now.beginning_of_day}").each do |choice_modles|
	    choice_modles.record_notice
	    choice_course.had_email = 1
	    choice_modles.save
	  end
    end

    def record_notice
      mail_temple = MailTemplate.find(:last,:conditions=>"1=1")
      self.student_course_records.each do |record|
        recevier = record.stu_reg_inf.email
        message = mail_temple.content
        subject = "选课通知"
        Emailer.start_course_emails(recevier,subject, message).deliver
      end
    end
 
    # # 定时关闭选课(是否发通知？)
    # def self.end_choice_course
    #     StudentChoiceCourse.find(:all,:conditions=>"state = 1 and end_time = #{Time.now.beginning_of_day}").each do |student_choice_course|
    #         student_choice_course.state = 0 #设为不可选择，但是选择的状态status先不变
    #         student_choice_course.save
    #         student_choice_course.student_choice_classes.each do |student_choice_classe|
    #           student_choice_classe.state = 0
    #           student_choice_classe.save
    #         end
    #         student_choice_course.student_course_records.each do |student_course_record|
    #           student_course_record.state = 0
    #           student_course_record.save
    #         end
    #     end
    # end
    
    
    # # 初始化本课选课学生数据
    # def init_student_course_records
    #   # 修改启动时将所有已有记录激活为可选状态
    #   self.student_course_records.each do |student_course_record|
    #     student_course_record.state = 1
    #     student_course_record.save
    #   end
    #   # 新建或者修改的情况下可能添加了新班级，新建recorde
    #   self.student_choice_classes.each do |choice_class|
    #   choice_class.state = 1
    #   choice_class.save
    #   student_choice_course_id = choice_class.student_choice_course_id
    #   student_choice_class_id = choice_class.id
    #   student_class_module_id = choice_class.student_class_module_id
    #   course_id = choice_class.course_id
    #   search_type = choice_class.search_type
    #   scor = choice_class.scor
    #   weight = choice_class.weight
    #   course_type = choice_class.course_type
    #   #scor_or_weight = choice_class.scor_or_weight
    #   train_plan_id = choice_class.train_plan_id
    #   # 因为可能再次添加了一些班级的人，所以得可以再跑！但是个人创建过记录的不需要再执行了。
    #       choice_class.student_class.stu_reg_inf_ids.each do |stu_reg_inf_id|
    #         # 如果初始化过，则不再创建，如果已修过则不再创建。
    #             if StudentCourseRecord.find_by_stu_reg_inf_id_and_student_choice_class_id(stu_reg_inf_id,student_choice_class_id).blank? && !CoursesStuRegInf.find(:all,:conditions=>"stu_reg_inf_id = #{stu_reg_inf_id} and course_id = #{course_id} and ( situation='已选' or situation='通过' or situation='免修') " ).present?
    #                 if self.tow_only_one == 1 || (self.tow_only_one == 0 && !CoursesStuRegInf.find(:all,:conditions=>"stu_reg_inf_id = #{stu_reg_inf_id} and course_id = #{course_id} and ( situation='已选' or situation='通过' or situation='免修') " ).present? )
    #                           student_record = StudentCourseRecord.new
    #                           student_record.stu_reg_inf_id = stu_reg_inf_id
    #                           student_record.student_choice_course_id = student_choice_course_id
    #                           student_record.student_choice_class_id = student_choice_class_id
    #                           student_record.student_class_module_id = student_class_module_id
    #                           student_record.course_id = course_id
    #                           student_record.scor = scor
    #                           student_record.weight = weight
    #                           student_record.search_type = search_type
    #                           student_record.state = 1  #已开启
    #                           student_record.status = 0 #未选择
    #                           student_record.course_type = course_type
    #                           student_record.scor_or_weight = 1 #scor_or_weight
    #                           student_record.train_plan_id = train_plan_id
    #                           student_record.save
    #                 end
    #             end
    #       end
    # end

end