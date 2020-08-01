#!/bin/bash

SQOOP_HOME=/opt/apps/sqoop

$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table category \
--hive-import \
--hive-table ods_exam.ods_category \
--delete-target-dir \
--num-mappers 1 \
--fields-terminated-by ',' \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table question_type \
--hive-import \
--hive-table ods_exam.ods_question_type \
--delete-target-dir \
--num-mappers 1 \
--fields-terminated-by ',' \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table question_difficulty \
--hive-import \
--hive-table ods_exam.ods_question_difficulty \
--delete-target-dir \
--num-mappers 1 \
--fields-terminated-by ',' \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table question \
--hive-import \
--hive-table ods_exam.ods_question \
--delete-target-dir \
--fields-terminated-by ',' \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table question_option \
--hive-import \
--hive-table ods_exam.ods_question_option \
--delete-target-dir \
--fields-terminated-by ',' \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template \
--hive-import \
--hive-table ods_exam.ods_paper_template \
--delete-target-dir \
--num-mappers 1 \
--fields-terminated-by ',' \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_category_ref \
--hive-import \
--hive-table ods_exam.ods_paper_template_category_ref \
--delete-target-dir \
--fields-terminated-by ',' \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_part \
--fields-terminated-by ',' \
--hive-import \
--hive-table ods_exam.ods_paper_template_part \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper_template_part_question_number \
--hive-import \
--fields-terminated-by ',' \
--hive-table ods_exam.ods_paper_template_part_question_number \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table exam \
--fields-terminated-by ',' \
--hive-import \
--hive-table ods_exam.ods_exam \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table exam_class_ref \
--fields-terminated-by ',' \
--hive-import \
--hive-table ods_exam.ods_exam_class_ref \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper \
--fields-terminated-by ',' \
--hive-import \
--hive-table ods_exam.ods_paper \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table paper_question \
--hive-import \
--fields-terminated-by ',' \
--hive-table ods_exam.ods_paper_question \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile


$SQOOP_HOME/bin/sqoop import \
--connect jdbc:mysql://phone01:3306/qianfeng \
--username root \
--password 123456 \
--table answer_paper \
--fields-terminated-by ',' \
--hive-import \
--hive-table ods_exam.ods_answer_paper \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile
