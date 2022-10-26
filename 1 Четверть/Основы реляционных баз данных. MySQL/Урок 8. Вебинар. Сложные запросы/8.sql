-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
-- который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT * FROM messages;
SELECT * FROM users;

SELECT 
	u2.id, 
	concat(u2.firstname, ' ', u2.lastname) AS name, 
	count(*) AS messages 
FROM users u 
JOIN messages m ON u.id = m.to_user_id 
JOIN users u2 ON m.from_user_id = u2.id
WHERE u.id = 6 GROUP BY u2.id ORDER BY messages DESC LIMIT 1;

-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

SELECT * FROM  posts_likes;
SELECT * FROM  profiles;
SELECT * FROM posts;

SELECT count(*) AS likes  
FROM posts p 
JOIN posts_likes pl ON p.id = pl.post_id 
JOIN profiles p2 ON p.user_id = p2.user_id
WHERE timestampdiff(YEAR, p2.birthday, now()) < 10;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT 
	CASE p.gender
		WHEN 'f' THEN 'female'
		WHEN 'm' THEN 'male'
	END AS asd,
		count(*) AS likes 
FROM posts_likes pl JOIN profiles p ON pl.user_id = p.user_id
GROUP BY gender HAVING gender != 'x' ORDER BY likes DESC LIMIT 1;
	