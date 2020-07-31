-- 创建销售订单主题的ods层
CREATE DATABASE IF NOT EXISTS `ods_exam`;

--试卷模板题型组成
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_paper_template_part` (
  `id` int,
  `paper_template_id` int COMMENT '试卷模板id',
  `question_type_id` int  COMMENT '试题类型id',
  `per_question_mark` int  COMMENT '每题分数',
  `sort` int  COMMENT '试题类型排序',
  `selected` int  COMMENT '0:未被选择\r\n1:已选择\r\n'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--试卷模板题型组成各难度题数
CREATE TABLE IF NOT EXISTS `ods_exam`.`paper_template_part_question_number` (
  `id` int ,
  `paper_template_part_id` int  COMMENT '试卷模板组成id',
  `question_difficulty_id` int  COMMENT '难度id',
  `question_number` int  COMMENT '试题数量'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--考试
CREATE TABLE IF NOT EXISTS `ods_exam`.`exam` (
  `id` int ,
  `name` string COMMENT '考试名',
  `paper_template_id` int COMMENT '试卷模板id',
  `subject_id` int  COMMENT '学科id',
  `subject_name` string  COMMENT '学科名',
  `limit_minute` int  COMMENT '答题限时(分钟)',
  `pass_score` int  COMMENT '合格分',
  `full_mark` double  COMMENT '总分',
  `volume_num` int  COMMENT '生成试卷数',
  `remark` string COMMENT '考试说明',
  `state` int  COMMENT '0:未开始\r\n1:进行中\r\n2:已结束\r\n',
  `del` int  COMMENT '0:删除 1:正常',
  `start_time` string  COMMENT '开考时间',
  `modifier_id` int ,
  `modifier_name` string ,
  `modify_time` string ,
  `creator_id` int  COMMENT '创建人id',
  `creator_name` string ,
  `create_time` string  COMMENT '创建时间',
  `publish` int COMMENT '0: 学生不可查看 1:学生可查看'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;


--考试与班级关联表
CREATE TABLE IF NOT EXISTS `ods_exam`.`exam_class_ref` (
  `id` int  COMMENT '主键ID',
  `exam_id` int COMMENT '考试id',
  `class_id` int COMMENT '班级id',
  `class_name` string COMMENT '班级名称'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;


--试卷表
CREATE TABLE IF NOT EXISTS `ods_exam`.`paper` (
  `id` int ,
  `exam_id` int  COMMENT '考试id',
  `is_objective` int  COMMENT '是否全为客观题\r\n0:不是全客,含主\r\n1:全客\r\n',
  `is_subjective` int  COMMENT '是否全部为主观题0:不是  1:是',
  `creator_id` int ,
  `creator_name` string ,
  `create_time` string 
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--试卷试题
CREATE TABLE IF NOT EXISTS `ods_exam`.`paper_question` (
  `id` int ,
  `paper_id` int COMMENT '试卷id',
  `question_id` int COMMENT '试题id'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;


--答卷
CREATE TABLE IF NOT EXISTS `ods_exam`.`answer_paper` (
  `id` int  COMMENT '主键ID',
  `exam_id` int COMMENT '考试ID',
  `paper_id` int COMMENT '试卷id',
  `examinee_id` int COMMENT '考生id',
  `examinee_name` string COMMENT '考生名称',
  `examinee_num` string COMMENT '考生学号',
  `class_id` int COMMENT '班级id',
  `class_name` string COMMENT '班级名称',
  `start_date` string COMMENT '开考时间',
  `exam_time` bigint COMMENT '已考时间',
  `submit_time` string  COMMENT '交卷时间',
  `objective_mark` double  COMMENT '客观题分数',
  `subject_mark` double  COMMENT '主观题分数',
  `subject_smart_mark` int  COMMENT '主观题智能评卷得分',
  `check_state` int  COMMENT '批阅状态 \r\n0:为批阅\r\n1:已批阅',
  `teacher_id` int  COMMENT '阅卷老师ID',
  `objective_answer_json` string COMMENT '客观答案串',
  `subject_answer_json` string COMMENT '主观答案串',
  `subject_check_json` string COMMENT '主观阅卷串',
  `objective_check_json` string COMMENT '客观阅卷串',
  `evaluation_opinions` string COMMENT '评价意见'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;