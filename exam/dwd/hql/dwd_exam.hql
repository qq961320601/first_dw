-- 创建exam主题的dwd层
CREATE DATABASE IF NOT EXISTS `dwd_exam`;


-- 答题汇总表
CREATE TABLE IF NOT EXISTS `dwd_exam`.`dwd_answer_summary` (
   exam_id int,
   exam_start_time string,
   class_id int,
   class_name string,
   examinee_id int,
   examinee_name string,
   submit_time string,
   answer_time int,
   objective_mark double,
   subject_mark double,
   total_mark double
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;

--答题详情表,dwd_answer_detail
CREATE TABLE IF NOT EXISTS `dwd_exam`.`dwd_answer_detail` (
`exam_id` int,
`exam_start_time` string,
`class_id` int,
`class_name` string,
`examinee_id` int,
`examinee_name` string,
`question_id` int,
`question_type` string,
`question_stage` string,
`question_difficulty_name` string,
`is_objective` int,
`per_question_mark` int,
`score` string,
`is_current` string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\001'
STORED AS textfile
;


-- 向答题汇总表插入数据
INSERT OVERWRITE TABLE `dwd_exam`.`dwd_answer_summary` IF NOT EXISTS
SELECT 
t1.id,
t1.start_time,
t2.class_id,
t2.class_name,
t2.examinee_id,
t2.examinee_name,
t2.submit_time,
t2.exam_time,
nvl(t2.objective_mark,0) objective_mark,
nvl(t2.subject_mark,0) subject_mark,
nvl(t2.objective_mark,0)+nvl(t2.subject_mark,0) total_mark
from `ods_exam`.`ods_exam` t1
join `ods_exam`.`ods_answer_paper` t2
on t1.id=t2.exam_id;


--向答题详情表插入数据 dwd_answer_detail
insert overwrite table  `dwd_exam`.`dwd_answer_detail`
select t3.id as exam_id,
       t3.start_time as exam_start_time,
       t1.class_id,
       t1.class_name,
       t1.examinee_id,
       t1.examinee_name,
       t4.question_id,
       case when t7.type =1 then '单选题'
            when t7.type =2 then '多选题'
            when t7.type =3 then '判断题'
            when t7.type =4 then '填空题'
            when t7.type =5 then '简答题'
            when t7.type =6 then '编程题'
        end as question_type,
       case when t11.create_time<'2018-09-10' then '一阶段'
            when t11.create_time>='2018-09-10' then '二阶段'
        end as question_stage,
       t6.name as question_difficulty_name,
       t7.is_objective,
       t8.per_question_mark,
       nvl(if(t9.score is null,t10.score,t9.score),0) as score,
       if(nvl(if(t9.score is null,t10.score,t9.score),0)=0,'不正确','正确') as is_current
  from ods_exam.ods_answer_paper t1
 inner join ods_exam.ods_exam t3
    on t1.exam_id=t3.id
 inner join ods_exam.ods_paper_question t4
    on t1.paper_id=t4.paper_id
 inner join ods_exam.ods_question t5
    on t4.question_id=t5.id
 inner join ods_exam.ods_question_difficulty t6
    on t5.question_difficulty_id=t6.id
 inner join ods_exam.ods_question_type t7
    on t5.question_type_id=t7.id
 inner join ods_exam.ods_paper_template_part t8
    on t7.id=t8.question_type_id
   and t3.paper_template_id=t8.paper_template_id
 inner join (select  o1.examinee_id,
                     o1.examinee_name,
                     d3.question_id,
                     get_json_object(o1.objective_answer_json,CONCAT('$.',cast(d3.question_id as string),'.score'))  as score
               from  ods_exam.ods_answer_paper o1
               inner join ods_exam.ods_paper_question d3
                  on o1.paper_id=d3.paper_id) t9
         on t1.examinee_id=t9.examinee_id
        and t4.question_id=t9.question_id
 inner join (select  o1.examinee_id,
                     o1.examinee_name,
                     d3.question_id,
                     if(get_json_object(o1.subject_answer_json,CONCAT('$.',cast(d3.question_id as string),'.score'))='',0,get_json_object(o1.subject_answer_json,CONCAT('$.',cast(d3.question_id as string),'.score')))  as score
               from  ods_exam.ods_answer_paper o1
               inner join ods_exam.ods_paper_question d3
                  on o1.paper_id=d3.paper_id) t10
    on t1.examinee_id=t10.examinee_id
   and t4.question_id=t10.question_id
 inner join ods_exam.ods_paper_template t11
    on t8.paper_template_id=t11.id;
    
    
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


drop table `dws_exam`.`dws_exam_objective_fluctuation`;
CREATE TABLE IF NOT EXISTS `dws_exam`.`dws_exam_objective_fluctuation` (
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

insert overwrite table `dws_exam`.`dws_exam_objective_fluctuation`
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
  from dwd_answer_summary;