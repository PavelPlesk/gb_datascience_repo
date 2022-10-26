-- Подсчитайте средний возраст пользователей в таблице users

SELECT * FROM users;
SELECT name, birthday_at, TIMESTAMPDIFF(YEAR, birthday_at, curdate()) AS age FROM users;
SELECT avg(TIMESTAMPDIFF(YEAR, birthday_at, curdate())) FROM users;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT dayofweek(birthday_at) AS wday, count(*) FROM users GROUP BY wday;

-- Подсчитайте произведение чисел в столбце таблицы

SELECT exp(sum(LN(id))) AS prod FROM users;