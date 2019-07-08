use 'csv';
drop procedure if exists 'myprocname';

delimiter //
use 'csv';//
CREATE DEFINER=`myusername`@`%` PROCEDURE `myprocname`(IN myvar VARCHAR(3500))
BEGIN
     DECLARE my_id INT;

     SELECT id INTO veh_id FROM mytable WHERE something = myvar;

END//

DELIMITER //
