-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT * FROM orders;
SELECT * FROM users;

INSERT orders (user_id) VALUES (1), (1), (3);

SELECT id, name FROM users 
WHERE id IN (SELECT user_id FROM orders); 

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT * FROM products;
SELECT * FROM catalogs;

SELECT 
	name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS catalog
FROM products;

-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	from_ varchar(15),
	to_ varchar(15) 
	);

CREATE TABLE cities (
	label varchar(15) UNIQUE,
	name varchar(15) 
	);

INSERT IGNORE flights (from_, to_) 
VALUES ('moscow', 'omsk'),
	   ('novgorod', 'kazan'),
	   ('irkutsk', 'moscow'),
	   ('omsk', 'irkutsk'),
	   ('moscow', 'kazan'),
	   ('moscow', 'minsk');

INSERT IGNORE cities (label, name) 
VALUES ('moscow', 'Москва'),
	   ('novgorod', 'Новгород'),
	   ('irkutsk', 'Иркутск'),
	   ('omsk', 'Омск'),
	   ('kazan', 'Казань');
	  
SELECT
	id,
	(SELECT name FROM cities WHERE label = from_) AS 'from',
	IF (to_ IN (SELECT label FROM cities), (SELECT name FROM cities WHERE label = to_), to_) AS 'to'
FROM flights;


