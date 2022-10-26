/*В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.*/

START TRANSACTION;
INSERT INTO sample.users
SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
SELECT * FROM shop.users;
SELECT * FROM sample.users;
COMMIT;

/*Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.*/

USE store;
SELECT * FROM products;

CREATE OR REPLACE VIEW products_short AS 
SELECT p.name AS product, c.name AS catalog 
FROM products p 
JOIN catalogs c ON p.catalog_id = c.id;

SHOW tables;

SELECT * FROM products_short;

/*(по желанию) Пусть имеется таблица с календарным полем created_at. 
В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, 
если дата присутствует в исходном таблице и 0, если она отсутствует.*/

SELECT * FROM orders ORDER BY created_at DESC ;
INSERT INTO orders (user_id, created_at)
VALUES ('1', '2018-08-01'),
	   ('2', '2018-08-04'),
	   ('3', '2018-08-06'),
	   ('4', '2018-08-07'),
	   ('3', '2018-08-13'),
	   ('2', '2018-08-20'),
	   ('1', '2018-08-30'); 

CREATE OR REPLACE VIEW dates AS SELECT aug.dates FROM (SELECT adddate('2018-08-01', t1.i*10 + t0.i) AS dates FROM 
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS t0,
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) AS t1) aug 
WHERE aug.dates <= '2018-08-31'; 
 
SELECT 
	dates,
	MAX(IF (NOT o.created_at IS NULL, 1, 0)) AS order_created
FROM dates d 
LEFT JOIN orders o ON d.dates = date(o.created_at)
GROUP BY dates 
ORDER BY dates;


/*(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.*/

PREPARE clean_orders FROM "DELETE FROM orders WHERE created_at NOT IN (SELECT * FROM (SELECT created_at FROM orders ORDER BY created_at DESC LIMIT 5) temp)";
START TRANSACTION;
EXECUTE clean_orders;
SELECT * FROM orders;
ROLLBACK;

