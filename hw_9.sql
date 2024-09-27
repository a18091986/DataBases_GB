Практическое задание по теме “Транзакции, переменные, представления”

-----------------------------------------
1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
-----------------------------------------

start transaction;
insert into sample.users select*from shop.users where id = 1;
delete from shop.users where id = 1;
commit;

-----------------------------------------
2. Создайте представление, которое выводит название name товарной позиции из таблицы products
и соответствующее название каталога name из таблицы catalogs.
-----------------------------------------

create view pred as
	SELECT products.name as product, catalogs.name as catalog 
	FROM products, catalogs 
	WHERE (catalogs.id = products.catalog_id);

select * from pred;

Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

-----------------------------------------
1. Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть 
доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.
-----------------------------------------
mysql> grant select on shop.* to u1;
Query OK, 0 rows affected (0.00 sec)

mysql> show grants for u1;
+--------------------------------------+
| Grants for u1@%                      |
+--------------------------------------+
| GRANT USAGE ON *.* TO `u1`@`%`       |
| GRANT SELECT ON `shop`.* TO `u1`@`%` |
+--------------------------------------+

mysql> grant all on  shop.* to u2;
Query OK, 0 rows affected (0.01 sec)

mysql> show grants for u2;
+----------------------------------------------+
| Grants for u2@%                              |
+----------------------------------------------+
| GRANT USAGE ON *.* TO `u2`@`%`               |
| GRANT ALL PRIVILEGES ON `shop`.* TO `u2`@`%` |
+----------------------------------------------+
2 rows in set (0.00 sec)

Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-----------------------------------------
1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу 
"Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
-----------------------------------------

create function hello()
returns varchar(50) deterministic
begin 
	declare answer varchar(50);
	case
		WHEN current_time() between '06:00:00' and '12:00:00' 
			then set answer = 'Доброе утро';
		WHEN current_time() between '12:00:00' and '18:00:00' 
			then set answer = 'Добрый день';
		WHEN current_time() between '18:00:00' and '00:00:00' 
			then set answer =  'Добрый вечер';
		WHEN current_time() between '00:00:00' and '06:00:00' 
			then set answer =  'Доброй ночи';
	END case;
    return answer;
 end; //

-----------------------------------------
2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля 
принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
При попытке присвоить полям NULL-значение необходимо отменить операцию.
-----------------------------------------

CREATE TRIGGER check_null_before_insert BEFORE INSERT ON products
FOR EACH ROW 
	BEGIN
		IF NEW.name = 'NULL' and NEW.description = 'NULL' THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Name or descriprion have to be not null!';
		END IF;
	END//
