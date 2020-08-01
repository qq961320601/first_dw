-- 创建销售订单主题的dwd层
CREATE DATABASE IF NOT EXISTS `dwd_exam`;


-- 答题汇总表
CREATE TABLE `dwd_exam`.`dwd_answer_summary` (
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