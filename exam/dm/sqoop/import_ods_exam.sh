--1
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_category \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--2
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_question_type \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--3
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_question_difficulty \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--4
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_question \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--5
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_question_option \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--6
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper_template \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--7
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper_template_category_ref \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--8
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper_template_part \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--9
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper_template_part_question_number \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--10
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_exam \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--11
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_exam_class_ref \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--12
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--13
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_paper_question \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile

--14
sqoop import \
--connect jdbc:mysql://qphone02:3306/qianfeng \
--username root \
--password 123456 \
--table customer \
--hive-import \
--hive-table ods_exam.ods_answer_paper \
--delete-target-dir \
--num-mappers 1 \
--hive-overwrite \
--as-textfile
