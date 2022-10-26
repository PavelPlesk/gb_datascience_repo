-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT * FROM messages;
SELECT * FROM users;

SELECT 
	from_user_id AS user_id,
	(SELECT concat_ws(' ', firstname, lastname) FROM users WHERE id = from_user_id) AS user_name, 
	count(to_user_id) AS messages_count 
FROM messages WHERE to_user_id = 11 GROUP BY from_user_id ORDER BY messages_count DESC LIMIT 1;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT * FROM  posts_likes;
SELECT * FROM  profiles;
SELECT * FROM posts;

SELECT user_id FROM profiles WHERE timestampdiff(YEAR, birthday, now()) < 10;

SELECT id FROM posts WHERE user_id IN (SELECT user_id FROM profiles WHERE timestampdiff(YEAR, birthday, now()) >= 36);

SELECT count(*) FROM posts_likes 
WHERE post_id IN 
	(SELECT id FROM posts WHERE user_id IN 
		(SELECT user_id FROM profiles WHERE timestampdiff(YEAR, birthday, now()) < 10));

-- Определить кто больше поставил лайков (всего): мужчины или женщины.
	
SELECT 
	(SELECT gender FROM profiles WHERE user_id = (SELECT user_id FROM posts WHERE id = post_id)) AS gender,
	count(*) AS likes
FROM posts_likes GROUP BY gender HAVING gender != 'x' ORDER BY likes DESC LIMIT 1;
	

