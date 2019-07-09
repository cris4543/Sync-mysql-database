#!/bin/bash
echo "Option:"
echo -e "	1.display\n	2.Add file\n	3.drop database"
read option
if [ $option -eq 1 ]
	then
		mysql -uroot -e 'show databases;'
		echo "enter database name"
		read s1d
		mysql -uroot <<MYSQL_SCRIPT
		use $s1d;
		show tables;
MYSQL_SCRIPT
		echo "enter table name"
		read t1d
		mysql -uroot <<MYSQL_SCRIPT 
		Use $s1d;
		select * from $t1d;
MYSQL_SCRIPT

elif [ $option -eq 2 ]
	then
	echo "Enter database name:"
	read na
	db1=$(mysql -e "show databases like '"$na"';" | grep "$na" > /dev/null; echo "$?")

		if [ $db1 -eq 0 ];
			then
				echo " a database with name $na already exists. exiting"
		else
				mysql -uroot -e "Create database $na; Use $na; Grant all privileges on *.* to 'osboxes'@'%' identified by 'osboxes.org';"
		fi
echo "enter table name:"
read t1
echo "Database name of server1:"
read data
echo "Table name of server1:"
read table
mysql -uroot <<MYSQL_SCRIPT
use $na;
create table $t1 ( id int(20) not null auto_increment, name varchar(20), class varchar(20), primary key (id)) engine=federated default charset=latin1 
connection='mysql://osboxes:osboxes.org@192.168.83.5:3306/$data/$table';
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
                use $na;
                insert into $t1 values ($f1,'$f2','$f3');
                select * from $t1;
MYSQL_SCRIPT
	done
elif [ $option -eq 3 ]
	then
	echo "List of existing database:"
	mysql -uroot -e 'show databases;'
	echo -e "\nEnter database name you want to delete"
	read na1
	mysql -uroot <<MYSQL_SCRIPT
	use $na1;
	drop database $na1;
	show databases;
MYSQL_SCRIPT
echo
echo -e "\n$na1 deleted"
else
	exit;
fi
