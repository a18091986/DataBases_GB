---------------------------
1. ��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.

SELECT * FROM users WHERE id IN (SELECT user_id FROM orders);
------------------------------

2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.

SELECT products.name, catalogs.name FROM products, catalogs WHERE (catalogs.id = products.catalog_id);
=--------------------------------

3. (�� �������) ����� ������� ������� ������ flights 
(id, from, to) � ������� ������� cities (label, name).
���� from, to � label �������� ���������� �������� 
�������, ���� name � �������. �������� ������ ������ flights 
� �������� ���������� �������.


SELECT one.id, one.name, two.name from 
(SELECT flights.id, cities.name FROM flights, cities WHERE (flights.`from` = cities.label) ORDER BY flights.id) AS one JOIN
(SELECT flights.id, cities.name FROM flights, cities WHERE (flights.`to` = cities.label) ORDER BY flights.id) AS two
on one.id = two.id
order by one.id
--------------------------------