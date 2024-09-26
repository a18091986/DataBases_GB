---------------------------
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT * FROM users WHERE id IN (SELECT user_id FROM orders);
------------------------------

2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT products.name, catalogs.name FROM products, catalogs WHERE (catalogs.id = products.catalog_id);
=--------------------------------

3. (по желанию) Пусть имеется таблица рейсов flights 
(id, from, to) и таблица городов cities (label, name).
Поля from, to и label содержат английские названия 
городов, поле name — русское. Выведите список рейсов flights 
с русскими названиями городов.


SELECT one.id, one.name, two.name from 
(SELECT flights.id, cities.name FROM flights, cities WHERE (flights.`from` = cities.label) ORDER BY flights.id) AS one JOIN
(SELECT flights.id, cities.name FROM flights, cities WHERE (flights.`to` = cities.label) ORDER BY flights.id) AS two
on one.id = two.id
order by one.id
--------------------------------