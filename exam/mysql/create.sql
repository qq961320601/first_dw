CREATE TABLE IF NOT EXISTS `dm_exam_objective_fluctuation` (
   exam_id int(11),
   exam_start_time datetime,
   class_id int(11),
   class_name varchar(200),
   examinee_id int(11),
   examinee_name varchar(200),
   objective_mark double(38,2),
   objective_mark_progress double(38,2),
   subject_mark double(38,2),
   subject_mark_progress double(38,2),
   total_mark double(38,2),
   total_mark_progress double(38,2)
)  DEFAULT CHARSET=utf8 COMMENT='多次考试成绩波动表';



CREATE TABLE IF NOT EXISTS `dm_single_exam_correct` (
`exam_id` int(11),
`exam_start_time` datetime,
`class_id` int(11),
`class_name` varchar(200),
`examinee_id` int(11),
`examinee_name` varchar(200),
`question_stage` varchar(200),
`question_erroe_num` int(11),
`question_currect_num` int(11),
`question_total_num` int(11),
`question_currect_rate` varchar(200)
)DEFAULT CHARSET=utf8 COMMENT='个人单次考试各阶段总正确率表';



CREATE TABLE IF NOT EXISTS `dm_single_exam_difficulty` (
`exam_id` int(11),
`exam_start_time` datetime,
`class_id` int(11),
`class_name` varchar(200),
`examinee_id` int(11),
`examinee_name` varchar(200),
`question_stage` varchar(200),
`question_difficulty_name` varchar(200),
`question_erroe_num` int(11),
`question_currect_num` int(11),
`question_total_num` int(11),
`question_currect_rate` varchar(200)
)DEFAULT CHARSET=utf8 COMMENT='个人单次考试各阶段难易程度总正确率表';

CREATE TABLE IF NOT EXISTS `dm_exam`.`dm_user_modle` (
   class_id int(11),
   class_name varchar(200),
   examinee_id int(11),
   examinee_name varchar(200),
   expression_ability varchar(200),
   understanding_ability varchar(200),
   program_ability varchar(200)
)DEFAULT CHARSET=utf8 COMMENT='用户模型表';