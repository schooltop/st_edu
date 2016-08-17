class StudentChoiceClass < ActiveRecord::Base
	# 由student_choice_courses 表对应的main_student_class_ids和repail_student_class_ids

	# DROP TABLE IF EXISTS `student_choice_classes`;
	# CREATE TABLE `student_choice_classes` (
	#   `id` int(11) NOT NULL AUTO_INCREMENT,
	#   `student_class_id` int(11) DEFAULT NULL COMMENT '该字段记录的是学生自己的班级',
	#   `course_id` int(11) DEFAULT NULL,
	#   `student_choice_course_id` int(11) DEFAULT NULL COMMENT '选课设置表id',
	#   `main_or_repair` int(11) DEFAULT NULL COMMENT '主选or补选主要用来查看区分',
	#   `course_type` int(11) DEFAULT NULL COMMENT '必修、选修,用来判别分组',
	#   `state` int(11) DEFAULT NULL COMMENT '状态',
	#   `scor` int(11) DEFAULT NULL,
	#   `weight` int(11) DEFAULT NULL,
	#   `transfer_class_id` int(11) DEFAULT NULL COMMENT '迁移班级',
	#   `train_plan_id` int(11) DEFAULT NULL COMMENT '关联培养方案',
	#   student_class_module_id
	#   PRIMARY KEY (`id`)
	# ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

	belongs_to :student_choice_course
	#belongs_to :train_plan
	has_many :student_course_records
	#belongs_to :student_class

end