--多次考试绩波动表
CREATE DATABASE IF NOT EXISTS `dm_exam`;
drop table if exists `dm_exam`.`dm_exam_objective_fluctuation`;
CREATE TABLE IF NOT EXISTS `dm_exam`.`dm_exam_objective_fluctuation` (
   exam_id int,
   exam_start_time string,
   class_id int,
   class_name string,
   examinee_id int,
   examinee_name string,
   objective_mark double,
   objective_mark_progress double,
   subject_mark double,
   subject_mark_progress double,
   total_mark double,
   total_mark_progress double
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

insert overwrite table `dm_exam`.`dm_exam_objective_fluctuation`
select exam_id,
       exam_start_time,
       class_id,
       class_name,
       examinee_id,
       examinee_name,
       objective_mark,
       objective_mark-lag(objective_mark,1,0) over(partition by class_id,examinee_id order by exam_id) as objective_mark_progress,
       subject_mark,
       subject_mark-lag(subject_mark,1,0) over(partition by class_id,examinee_id order by exam_id) as subject_mark_progress,
       total_mark,
       total_mark-lag(total_mark,1,0) over(partition by class_id,examinee_id order by exam_id) as total_mark_progress
  from dwd_exam.dwd_answer_summary;
  
--用户模型表
CREATE TABLE IF NOT EXISTS `dm_exam`.`dm_user_modle` (
   class_id int,
   class_name string,
   examinee_id int,
   examinee_name string,
   expression_ability string,
   understanding_ability string,
   program_ability string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile;

insert overwrite table `dm_exam`.`dm_user_modle`
select class_id,
       class_name,
       examinee_id,
       examinee_name,
       concat(round( nvl(sum(case when question_type = '简答题' then question_currect_num else 0 end )/sum(case when question_type = '简答题' then question_total_num else 0 end)*100,2),0),'%') as expression_ability,
       concat(round((nvl(sum(case when question_type = '单选题' then question_currect_num else 0 end )/sum(case when question_type = '单选题' then question_total_num else 0 end)*0.3,0)
                    +nvl(sum(case when question_type = '多选题' then question_currect_num else 0 end )/sum(case when question_type = '多选题' then question_total_num else 0 end)*0.5,0)
                    +nvl(sum(case when question_type = '判断题' then question_currect_num else 0 end )/sum(case when question_type = '判断题' then question_total_num else 0 end)*0.2,0))*100,2),'%') as understanding_ability,
       concat(round( nvl(sum(case when question_type ='编程题' then question_currect_num else 0 end )/sum(case when question_type = '编程题' then question_total_num else 0 end)*100,2),0),'%') as program_ability
  from `dws_exam`.`dws_single_stage_correct`
 group by class_id,
          class_name,
          examinee_id,
          examinee_name;



--个人单次考试各阶正确率表
drop table if exists `dm_exam`.`dm_single_exam_correct`;
CREATE TABLE IF NOT EXISTS `dm_exam`.`dm_single_exam_correct` (
`exam_id` int,
`exam_start_time` string,
`class_id` int,
`class_name` string,
`examinee_id` int,
`examinee_name` string,
`question_stage` string,
`question_erroe_num` int,
`question_currect_num` int,
`question_total_num` int,
`question_currect_rate` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile;


insert overwrite table `dm_exam`.`dm_single_exam_correct` 
select exam_id,
       exam_start_time,
       class_id,
       class_name,
       examinee_id,
       examinee_name,
       question_stage,
       sum(case when is_current ='不正确' then 1 else 0 end ) as question_erroe_num,
       sum(case when is_current ='正确' then 1 else 0 end ) as question_current_num,
       count(0) as question_total_num,
       concat(round(sum(case when is_current ='正确' then 1 else 0 end )/count(0)*100,2),'%') as question_currect_rate
  from `dwd_exam`.`dwd_answer_detail`
 group by exam_id,
          exam_start_time,
          class_id,
          class_name,
          examinee_id,
          examinee_name,
          question_stage;
          
--个人单次考试各阶段难易度正确率表
drop table if exists `dm_exam`.`dm_single_exam_difficulty`; 
CREATE TABLE IF NOT EXISTS `dm_exam`.`dm_single_exam_difficulty` (
`exam_id` int,
`exam_start_time` string,
`class_id` int,
`class_name` string,
`examinee_id` int,
`examinee_name` string,
`question_stage` string,
`question_difficulty_name` string,
`question_erroe_num` int,
`question_currect_num` int,
`question_total_num` int,
`question_currect_rate` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile;


insert overwrite table `dm_exam`.`dm_single_exam_difficulty` 
select exam_id,
       exam_start_time,
       class_id,
       class_name,
       examinee_id,
       examinee_name,
       question_stage,
       question_difficulty_name,
       sum(case when is_current ='不正确' then 1 else 0 end ) as question_erroe_num,
       sum(case when is_current ='正确' then 1 else 0 end ) as question_current_num,
       count(0) as question_total_num,
       concat(round(sum(case when is_current ='正确' then 1 else 0 end )/count(0)*100,2),'%') as question_currect_rate
  from `dwd_exam`.`dwd_answer_detail`
 group by exam_id,
          exam_start_time,
          class_id,
          class_name,
          examinee_id,
          examinee_name,
          question_stage,
          question_difficulty_name;

