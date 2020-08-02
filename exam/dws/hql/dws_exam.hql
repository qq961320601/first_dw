--个人单次考试各题各阶段总正确率基础表
CREATE DATABASE if not exists `dws_exam` ;
drop table `dws_exam`.`dws_single_stage_correct`;
CREATE TABLE IF NOT EXISTS `dws_exam`.`dws_single_stage_correct` (
`exam_id` int,
`exam_start_time` string,
`class_id` int,
`class_name` string,
`examinee_id` int,
`examinee_name` string,
`question_stage` string,
`question_type` string,
`question_erroe_num` int,
`question_currect_num` int,
`question_total_num` int,
`question_currect_rate` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS orc;


insert overwrite table `dws_exam`.`dws_single_stage_correct` 
select exam_id,
       exam_start_time,
       class_id,
       class_name,
       examinee_id,
       examinee_name,
       question_stage,
       question_type,
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
          question_type;
          
--个人单次考试各题各阶段难易度正确率基础表
drop table `dws_exam`.`dws_single_stage_difficulty`; 
CREATE TABLE IF NOT EXISTS `dws_exam`.`dws_single_stage_difficulty` (
`exam_id` int,
`exam_start_time` string,
`class_id` int,
`class_name` string,
`examinee_id` int,
`examinee_name` string,
`question_stage` string,
`question_type` string,
`question_difficulty_name` string,
`question_erroe_num` int,
`question_currect_num` int,
`question_total_num` int,
`question_currect_rate` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS orc;


insert overwrite table `dws_exam`.`dws_single_stage_difficulty` 
select exam_id,
       exam_start_time,
       class_id,
       class_name,
       examinee_id,
       examinee_name,
       question_stage,
       question_type,
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
          question_difficulty_name,
          question_type;
         

--个人单次考试各阶正确率表
drop table `dws_exam`.`dws_single_exam_correct`;
CREATE TABLE IF NOT EXISTS `dws_exam`.`dws_single_exam_correct` (
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
STORED AS orc;


insert overwrite table `dws_exam`.`dws_single_exam_correct` 
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
drop table `dws_exam`.`dws_single_exam_difficulty`; 
CREATE TABLE IF NOT EXISTS `dws_exam`.`dws_single_exam_difficulty` (
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
STORED AS orc;


insert overwrite table `dws_exam`.`dws_single_exam_difficulty` 
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

