#!/bin/bash
config=/home/osboxes/first_task/mycnf.txt
echo "Select from the following:"
echo -e "	1.Create Database\n	2.Select Existing Database\n	3.Delete Database\n"
read value
case $value in
1)
echo "Enter database name:"
read name
db=$(mysql -e "show databases like'"$name"';" | grep "$name" > /dev/null; echo "$?")
    		if [ $db -eq 0 ];
                	then
                        	echo "A database with name $name already exists. exiting"
                	exit;
        	fi
mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE $name;
GRANT ALL PRIVILEGES ON *.* TO 'osboxes'@'192.168.83.5' identified by 'osboxes.org';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
echo "Enter table name:"
read table
echo -e "Enter the file name you want to insert:\n"
read data
mysql -uroot <<MYSQL_SCRIPT
use $name;
create table $table ( id int(20) not null auto_increment, name varchar(20), class varchar(20), primary key (id))engine=MyISAM auto_increment=13 default charset=latin1;
LOAD DATA LOCAL INFILE '/home/osboxes/first_task/$data' INTO TABLE $table;
MYSQL_SCRIPT
echo " Data inserted to database $name table $table "
<<"COMMENT"
echo " enter no. of row for table"
read n
echo
for (( i=0; i<$n; i++ ))
	do
		echo -e "insert values into table:\n"
		read -p "enter id" f1
		read -p "enter name" f2
		read -p "enter class" f3
		mysql -uroot <<MYSQL_SCRIPT
		use $name;
		insert into $table values ($f1,'$f2','$f3');
		select * from $table;
MYSQL_SCRIPT
	done
COMMENT
;;
2)
echo -e "List of existing database:\n"
mysql -uroot -e 'show databases;'
echo -e "\nSelect database:"
read db
mysql -uroot <<MYSQL_SCRIPT
use $db
show tables;
MYSQL_SCRIPT
echo -e "\n Option:"
echo -e "	1.View table\n	2.Insert into table\n	3.Create new table\n	4.delete selective data"
read op
	if [ $op -eq 1 ]
	then
		#echo -e "\nEnter table name:"
		mysql -uroot <<MYSQL_SCRIPT
		use $db
		show tables;
MYSQL_SCRIPT
		echo -e "\nEnter table name:"
		read tb
		mysql -uroot <<MYSQL_SCRIPT
		use $db
		select * from $tb;
MYSQL_SCRIPT
	elif [ $op -eq 2 ]
	then
echo -e "\nenter table name:"
read t
echo " enter no. of row for table"
read n
echo
for (( i=0; i<$n; i++ ))
        do
                echo -e "insert values into table:\n"
                read -p "enter id" f1
                read -p "enter name" f2
                read -p "enter class" f3
                mysql -uroot <<MYSQL_SCRIPT
                use $db;
                insert into $t values ($f1,'$f2','$f3');
                select * from $t;
MYSQL_SCRIPT
        done


	elif [ $op -eq 3 ]
	then
		echo -e "\nEnter table name:"
		read t
		mysql -uroot <<MYSQL_SCRIPT
		use $db
		create table $t ( id int(20) not null auto_increment, name varchar(20), class varchar(20), primary key (id))engine=MyISAM auto_increment=13 default charset=latin1;
MYSQL_SCRIPT
		echo " enter no. of row for table"
		read n
		echo
		for (( i=0; i<$n; i++ ))
        		do
                		echo -e "insert values into table:\n"
                		read -p "enter id" f1
                		read -p "enter name" f2
                		read -p "enter class" f3
                		mysql -uroot <<MYSQL_SCRIPT
                		use $db;
                		insert into $t values ($f1,'$f2','$f3');
				select * from $t;
MYSQL_SCRIPT
        	done
	elif [ $op -eq 4 ]
	then
		echo -e "\nEnter table name:"
                read t
		mysql -uroot <<MYSQL_SCRIPT
		use $db
		select * from $t;
MYSQL_SCRIPT
		echo "enter id of row which you want to delete"
		read num
                mysql -uroot <<MYSQL_SCRIPT
                use $db
		delete from $t where id  = $num;
MYSQL_SCRIPT
	else
		echo "exiting"
		exit; 
	fi
;;
3)
echo "list of existing database:"
mysql -uroot -e 'show databases;'
echo -e "\nEnter Database name you want to delete"
read db
mysql -uroot <<MYSQL_SCRIPT
	use $db; 
	drop database $db;
	show databases;
MYSQL_SCRIPT
echo
echo -e "\n$db deleted"
;;
esac
