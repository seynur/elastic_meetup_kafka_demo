create database demo;
use demo;
create table foobar (c1 int, c2 varchar(255),create_ts timestamp DEFAULT CURRENT_TIMESTAMP , update_ts timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
insert into foobar (c1,c2) values(1,'foo');
