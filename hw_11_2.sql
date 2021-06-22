-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

> sadd ip '192.168.2.222' '192.168.2.255' '192.168.2.1'
(integer) 3

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

> set ivan ivan@mail.ru
OK
> set ivan@mail.ru ivan
OK
> set ann ann@mail.ru
OK
> set ann@mail.ru ann
OK
> get ann
"ann@mail.ru"
> get ivan@mail.ru
"ivan"

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

db.products.insertMany([
	{"name": "Intel Core i3-8100", "description": "Процессор для настольных ПК", "price": "8000.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name": "AMD FX-8320", "description": "Процессор для настольных ПК", "price": "4000.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()},
	{"name": "AMD FX-8320E", "description": "Процессор для настольных ПК", "price": "4500.00", "catalog_id": "Процессоры", "created_at": new Date(), "updated_at": new Date()}])

db.catalogs.insertMany([
	{"name": "Процессоры"}, {"name": "Мат.платы"}, {"name": "Видеокарты"}, {"name": "Жесткие диски"}, {"name": "Оперативная память"}, {"name": "Сетевое оборудование"}])