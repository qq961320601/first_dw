-- 创建销售订单主题的ods层
CREATE DATABASE IF NOT EXISTS `ods_exam`;

-- 分类表
CREATE TABLE `ods_exam`.`ods_category` (
  `id` int,
  `name` string COMMENT '分类名',
  `outline_json` string COMMENT '大纲json',
  `subject_id` int COMMENT '学科id',
  `subject_name` string COMMENT '学科名',
  `remark` string COMMENT '备注',
  `del` int COMMENT '0:删除  1正常',
  `modifier_id` int COMMENT '更新人id',
  `modifier_name` string COMMENT '更新人姓名',
  `modify_time` string COMMENT '更新时间',
  `creator_id` int COMMENT '创建人id',
  `creator_name` string COMMENT '创建人姓名',
  `create_time` string COMMENT '创建时间'
) COMMENT '分类表(小题库)'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试题类型
CREATE TABLE `ods_exam`.`ods_question_type` (
  `id` int,
  `type` int COMMENT '1:单选题\r\n2:多选题\r\n3, 判断\r\n4:填空题\r\n5:简答题\r\n6:编程',
  `name` string COMMENT '试题类型名',
  `is_objective` int COMMENT '0:主观 1:客观'
) COMMENT '试题类型表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试题难度
CREATE TABLE `ods_exam`.`ods_question_difficulty` (
  `id` int,
  `difficulty` int COMMENT '1:简单\r\n2:一般\r\n3:困难\r\n',
  `name` string COMMENT '试题难度名'
) COMMENT '难易度表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试题
CREATE TABLE `ods_exam`.`ods_question` (
  `id` int,
  `category_id` int COMMENT '分类id',
  `question_type_id` int COMMENT '试题类型',
  `question_difficulty_id` int COMMENT '试题难度',
  `state` int COMMENT '试题状态\r\n1:启用\r\n2:禁用\r\n',
  `content` string COMMENT '题干',
  `right_answer` string COMMENT '正确答案',
  `analyse` string COMMENT '正确答案解析',
  `del` int COMMENT '0:删除 1:正常',
  `modifier_id` int COMMENT '更新人id',
  `modifier_name` string COMMENT '更新人 姓名',
  `modify_time` string COMMENT '更新时间',
  `creator_id` int COMMENT '创建人id',
  `creator_name` string COMMENT '创建人姓名',
  `create_time` string COMMENT '创建时间'
) COMMENT '试题表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试题选项
CREATE TABLE `ods_exam`.`ods_question_option` (
  `id` int,
  `content` string COMMENT '选项题干',
  `sort` int COMMENT '试题排序(1,2,3…)',
  `question_id` int COMMENT '试题id',
  `is_right` int COMMENT '0:错误\r\n1:正确\r\n'
) COMMENT '试题选项表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试卷模板
CREATE TABLE `ods_exam`.`ods_paper_template` (
  `id` int,
  `name` string COMMENT '试卷模板名称',
  `subject_id` int COMMENT '学科id',
  `subject_name` string COMMENT '学科名',
  `state` int COMMENT '0: 未发布\r\n1: 发布',
  `total_mark` int COMMENT '  总分数',
  `del` int COMMENT '0:删除 1:正常',
  `modifier_id` int,
  `modifier_name` string,
  `modify_time` string,
  `creator_id` int COMMENT '创建人id',
  `creator_name` string,
  `create_time` string COMMENT '创建时间'
) COMMENT '试题模板(规则)表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

-- 试卷模板与分类关联表
CREATE TABLE `ods_exam`.`ods_paper_template_category_ref` (
  `id` int COMMENT '主键ID',
  `paper_template_id` int COMMENT '试卷模板id',
  `category_id` int COMMENT '分类id'
) COMMENT '试卷模板--分类--关联表'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS textfile
;

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
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_paper_template_part_question_number` (
  `id` int ,
  `paper_template_part_id` int  COMMENT '试卷模板组成id',
  `question_difficulty_id` int  COMMENT '难度id',
  `question_number` int  COMMENT '试题数量'
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--考试
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_exam` (
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
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_exam_class_ref` (
  `id` int  COMMENT '主键ID',
  `exam_id` int COMMENT '考试id',
  `class_id` int COMMENT '班级id',
  `class_name` string COMMENT '班级名称'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--试卷表
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_paper` (
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
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_paper_question` (
  `id` int ,
  `paper_id` int COMMENT '试卷id',
  `question_id` int COMMENT '试题id'
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
;

--答卷
CREATE TABLE IF NOT EXISTS `ods_exam`.`ods_answer_paper` (
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
