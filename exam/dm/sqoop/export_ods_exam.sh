SQOOP_HOME=/opt/apps/sqoop-1.4.6-cdh5.7.6

$SQOOP_HOME/bin/sqoop export \
--connect jdbc:mysql://qphone02:3306/dm_exam \
--username root \
--password 123456 \
--table dm_exam_objective_fluctuation \
--num-mappers 1 \
--export-dir /user/root/warehouse/dm_exam.db/dm_exam_objective_fluctuation \
--fields-terminated-by '\001' 


$SQOOP_HOME/bin/sqoop export \
--connect jdbc:mysql://qphone02:3306/dm_exam \
--username root \
--password 123456 \
--table dm_single_exam_correct \
--num-mappers 1 \
--export-dir /user/root/warehouse/dm_exam.db/dm_single_exam_correct \
--fields-terminated-by '\001'


$SQOOP_HOME/bin/sqoop export \
--connect jdbc:mysql://qphone02:3306/dm_exam \
--username root \
--password 123456 \
--table dm_single_exam_difficulty \
--num-mappers 1 \
--export-dir /user/root/warehouse/dm_exam.db/dm_single_exam_difficulty \
--fields-terminated-by '\001'


$SQOOP_HOME/bin/sqoop export \
--connect jdbc:mysql://qphone02:3306/dm_exam \
--username root \
--password 123456 \
--table dm_user_modle \
--num-mappers 1 \
--export-dir /user/root/warehouse/dm_exam.db/dm_user_modle \
--fields-terminated-by '\001'