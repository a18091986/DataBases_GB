-----------------------------------------------------
1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
-----------------------------------------------------
drop table if exists logs;
create table logs (
	added datetime,
    t_name varchar(255),
    id bigint(20),
    name varchar(255)
) ENGINE = ARCHIVE;

-- users ********************************

drop trigger if exists add_to_log_on_add_to_user;
delimiter | 
create trigger add_to_log_on_add_to_user after insert on users
for each row
begin
	insert into logs values (now(), 'users', new.id, new.name);
end |
delimiter ;
select * from users;
insert into users (name) values ('Петр');
select * from logs;

-- catalogs ************************

drop trigger if exists add_to_log_on_add_to_catalogs;
delimiter | 
create trigger add_to_log_on_add_to_catalogs after insert on catalogs
for each row
begin
	insert into logs values (now(), 'catalogs', new.id, new.name);
end |
delimiter ;
select * from catalogs;
insert into catalogs (name) values ('сетевые хранилища');
select * from logs;

-- products ********************************

drop trigger if exists add_to_log_on_add_to_products;
delimiter | 
create trigger add_to_log_on_add_to_products after insert on products
for each row
begin
	insert into logs values (now(), 'products', new.id, new.name);
end |
delimiter ;
select * from products;
insert into products (name) values ('AMD RAZEN 9');
select * from logs;