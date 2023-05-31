SET GLOBAL tmp_table_size = 1024*1024*1024;
SET GLOBAL innodb_buffer_pool_size = 3*1024*1024*1024 ;

truncate trx_address_tmp;

load data local infile '/root/trx/trx_address.csv'
into table trx_address_tmp
character set utf8
fields terminated by ','
lines terminated by '\n'
ignore 1 lines;


insert into trx_address(address)
select address from trx_address_tmp
on duplicate key update address = values(address);
