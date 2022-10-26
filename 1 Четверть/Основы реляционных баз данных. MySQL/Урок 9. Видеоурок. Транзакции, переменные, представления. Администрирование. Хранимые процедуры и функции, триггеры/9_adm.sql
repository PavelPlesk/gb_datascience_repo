-- Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, 
-- второму пользователю shop — любые операции в пределах базы данных shop.

USE shop;

CREATE USER shop_read;
GRANT SELECT ON shop.* TO shop_read; 
CREATE USER shop;
GRANT ALL ON shop.* TO shop; 

-- (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, 
-- имя пользователя и его пароль. Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления
-- username.

CREATE TABLE accounts(
	id SERIAL,
	name varchar(25) NOT NULL,
	password varchar(25) NOT NULL,
	PRIMARY KEY (name, password)
	);
	
SELECT * FROM accounts;

CREATE VIEW username AS SELECT id, name FROM accounts;

CREATE USER user_read;
GRANT SELECT ON shop.username TO user_read; 

/*
mysql> select * from username;
Empty set (0.00 sec)

mysql> select * from accounts;
ERROR 1142 (42000): SELECT command denied to user 'user_read'@'localhost' for table 'accounts'
*/