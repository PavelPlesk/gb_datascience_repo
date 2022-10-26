-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //

DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(25) DETERMINISTIC
BEGIN 
	RETURN CASE
		WHEN HOUR(NOW()) BETWEEN 6 AND 11 THEN 'Доброе утро'
		WHEN HOUR(NOW()) BETWEEN 12 AND 17 THEN 'Добрый день'
		ELSE 'Доброй ноч'
		END; 
END; //

-- DELIMITER;

SELECT hello()//

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DESCRIBE products//
ALTER TABLE products CHANGE desription description TEXT NULL//

DROP TRIGGER IF EXISTS name_description_both_null_insert//
CREATE TRIGGER name_description_both_null_insert
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Name and description are not able to be both null.";
	END IF;
END;//

DROP TRIGGER IF EXISTS name_description_both_null_update//
CREATE TRIGGER name_description_both_null_update
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF NEW.name IS NULL AND NEW.description IS NULL
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Name and description are not able to be both null.";
	END IF;
END;//

INSERT INTO products (name, description) VALUES (NULL, NULL);

UPDATE products SET name = NULL WHERE id = 1//

SELECT * FROM products//


-- (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

DROP FUNCTION IF EXISTS FIBONACCI_CYC// -- Вариант с циклом
CREATE FUNCTION FIBONACCI_CYC(n INT)
RETURNS INT DETERMINISTIC
BEGIN 
	IF n IN  (0, 1) THEN 
		RETURN n;
	ELSE
		BEGIN
			DECLARE i, a, b, с INT;
			SET i = 2;
			SET a = 0;
			SET b = 1;
			WHILE i <= n DO
				SET с = a + b;
				SET a = b;
				SET b = с;
				SET i = i + 1;
			END WHILE;	
			RETURN с;
		END;
	END IF; 
END; //


DROP PROCEDURE IF EXISTS  FIB// -- Вариант с рекурсией
CREATE PROCEDURE FIB(IN n INT, OUT с INT)
BEGIN 
	DECLARE x, y INT;
	SET max_sp_recursion_depth=255;
	IF n IN  (0, 1) THEN 
		SET с = n;
	ELSE
		CALL FIB(n-1, x);
		CALL FIB(n-2, y);
		SET с = (x + y);
	END IF; 	
END;//

DROP FUNCTION IF EXISTS FIBONACCI_REC//
CREATE FUNCTION FIBONACCI_REC(n INT)
RETURNS INT DETERMINISTIC
BEGIN 
	DECLARE c INT;
	CALL fib(n, c);
	RETURN c;
END; //

SET @n := 30//
SELECT @n AS n, FIBONACCI_CYC(@n) AS 'Cycle'//
SELECT @n AS n, FIBONACCI_REC(@n) AS 'Recursion'//
