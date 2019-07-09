delimiter //
drop procedure if exists loading_data;
create procedure loading_data(IN table_name varchar(20))
begin
set @table_name=table_name;
set @sql_text1=concat('Create table if not exists ',@table_name,' (id int(20) primary key,name varchar(20),salary int(7))'); prepare stmt1 from @sql_text1; execute stmt1; deallocate prepare stmt1;
set @sql_text2=concat('insert ignore into ',@table_name,' select * from Hello_csv'); prepare stmt2 from @sql_text2; execute stmt2; deallocate prepare stmt2;
set @sql_text3=concat('Select * from ',@table_name); prepare stmt3 from @sql_text3; execute stmt3; deallocate prepare stmt3;
drop table Hello_csv;
end;
//
