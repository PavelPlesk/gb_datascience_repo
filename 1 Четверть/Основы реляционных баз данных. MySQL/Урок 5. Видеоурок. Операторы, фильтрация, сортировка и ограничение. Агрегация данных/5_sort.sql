-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
USE store;

SELECT * FROM users;

ALTER TABLE users 
ADD COLUMN created_at_2 DATETIME DEFAULT NULL, 
ADD COLUMN updated_at_2 DATETIME DEFAULT NULL;

UPDATE users SET created_at_2 = now() WHERE created_at_2 IS NULL;
UPDATE users SET updated_at_2 = now() WHERE updated_at_2 IS NULL;

-- Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате "20.10.2017 8:10". 

ALTER TABLE users 
ADD COLUMN created_at_3 VARCHAR(25),
ADD COLUMN updated_at_3 VARCHAR(25);

UPDATE users SET created_at_3 = DATE_FORMAT(created_at, '%d.%m.%Y %r') WHERE created_at_3 IS NULL;
UPDATE users SET updated_at_3 = DATE_FORMAT(updated_at, '%d.%m.%Y %r') WHERE updated_at_3 IS NULL;

-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

ALTER TABLE users 
CHANGE COLUMN created_at_3 created_at_3_temp VARCHAR(25),
CHANGE COLUMN updated_at_3 updated_at_3_temp VARCHAR(25);

ALTER TABLE users 
ADD COLUMN created_at_3 DATETIME,
ADD COLUMN updated_at_3 DATETIME;

UPDATE users SET created_at_3 = STR_TO_DATE(created_at_3_temp, '%d.%m.%Y %r') WHERE created_at_3_temp IS NOT NULL;
UPDATE users SET updated_at_3 = STR_TO_DATE(updated_at_3_temp, '%d.%m.%Y %r') WHERE updated_at_3_temp IS NOT NULL;

SELECT created_at_3, created_at_3_temp, updated_at_3, updated_at_3_temp FROM users;

ALTER TABLE users 
DROP created_at_3_temp,
DROP updated_at_3_temp;

SELECT * FROM users;

ALTER TABLE users 
DROP created_at_2,
DROP updated_at_2,
DROP created_at_3,
DROP updated_at_3;

-- В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
-- если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

SELECT * FROM storehouses_products;
DESCRIBE storehouses_products;
INSERT IGNORE INTO storehouses_products (storehouse_id, product_id, value) 
VALUES ('1', '1', 0),
	   ('1', '3', 0),
	   ('2', '2', 100),
	   ('3', '1', 50);
	  
SELECT * FROM storehouses_products ORDER BY IF (value > 0, value, 99999999999);

-- Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

SELECT name, birthday_at FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');

-- Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY field(id, 5, 1, 2);
