delimiter //
use csv //
drop procedure if exists cre_table;
drop table if exists abcde;
create procedure cre_table()
begin
	create table if not exists abcde (Roll_no int(10), Name varchar(20), Class varchar (20), Grade varchar(10));
end; //
call cre_table; //
load data local infile '/home/osboxes/second_task/file.csv' into table abcde fields terminated by ',';//
drop procedure if exists load_dt;
create procedure load_dt(IN table_name varchar(30))
begin
set @table_name =table_name;
set @sql_text1=concat('insert into',@table_name,'select * form abcde'); prepare stmt1 from @sql_test1; execute stmt1; dellocate prepare stmt1;
set @sql_text2=concat('select * from ',@table_name); prepare stmt2 from @sql_text2; execute stmt2; deallocate prepare stmt2;
end;//
