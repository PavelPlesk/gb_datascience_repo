USE vk;

/* 9. Создадим таблицу с записями в ленту новостей и комментариями posts.
 * 
 * Сценарий: каждый пользователь может создавать записи в ленту или комментарий к существующей записи, содержащие текст и медиафайлы.
 * 
 * Каждая запись должна иметь автора из числа пользователей - свяжем это поле с таблицей users. 
 * 
 * Создадим отдельные поля для хранения текста и медиафайлов. Каждая запись может содержать до 3 медиафайлов.
 * Поле для храннения медиафайлов свяжем с таблицей media.
 * 
 * Также необходимо вести учет времени создания и обновления записей.  
 * 
 * Некоторые записи должны быть доступны всем пользователям, а некоторые - только друзьям автора. 
 * Для реализации этого функционала создадим логическое поле public.
 * 
 * Если запись является комментраием к другой запись, то в поле parent_id запишем id родительской записи,
 * в противном случает это поле принимает значение null. 
 * 
 * Так как каждый автор может создать много новостей (связь один к многим) используем id новости. 
 * Определим это поле как primary key. 
 * 
 * Для упрощения фильтрации комментариев создадим индекс для поля parent_id
 */

CREATE TABLE posts(
	id SERIAL PRIMARY KEY,
	author_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (author_id) REFERENCES users (id),
	txt TEXT,
	media_1 BIGINT UNSIGNED,
	FOREIGN KEY (author_id) REFERENCES users (id),
	media_2 BIGINT UNSIGNED,
	FOREIGN KEY (media_2) REFERENCES media (id),
	media_3 BIGINT UNSIGNED,
	FOREIGN KEY (media_3) REFERENCES media (id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	public BOOLEAN DEFAULT TRUE,
	parent_id BIGINT UNSIGNED NULL,
	FOREIGN KEY (parent_id) REFERENCES posts (id),
	INDEX (parent_id)
);

-- создаем новость
INSERT INTO posts VALUES (DEFAULT, 1, 'Тестовая новость!', 1, 2, NULL, DEFAULT, DEFAULT, TRUE, NULL); 

-- создаем комментарий к новости
INSERT INTO posts VALUES (DEFAULT, 2, 'Тестовый комментарий', NULL, NULL, 3, DEFAULT, DEFAULT, FALSE, 1); 

-- Пытаемся создать комментарий к несуществующей новости
INSERT INTO posts VALUES (DEFAULT, 2, 'Ошибка!', NULL, NULL, 3, DEFAULT, DEFAULT, FALSE, 55); 

SELECT * FROM posts;

-- DROP TABLE posts;

/* 10. Создадим таблицу с реакциями на записи.
 * 
 * Сценарий: каждый пользователь может выразить свою реакцию на запись.
 * 
 * Таблица включает поле с id записи, к которой относится реакция, и связанное с полем id таблицы posts, пользователь,
 * который эту реакцию оставил (поле связано с users.id) и тип реакции.
 * 
 * Так как к одной записи могут оставлять реакции разные пользователи, но один пользователь может оставить только одну реакции на конкретную запись 
 * (связь многие к одному), то нет необходимости создавать поле id. Вместо него используем составной PRIMARY KEY. 
 * 
 * Так как распространенной задачей будет подсчет количества реакций по типу для каждой записи, удобно использовать составной индекс
 * из полей post_id и reaction_type 
 */

CREATE TABLE reactions(
	post_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (post_id) REFERENCES posts (id),
	user_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id),
	reaction_type set('like', 'dislike', 'smile', 'laugh', 'sad', 'angry'),
	PRIMARY KEY (post_id, user_id),
	INDEX (post_id, reaction_type)
);

INSERT INTO reactions VALUES 
	(1, 1, 'like'),
	(2, 2, 'dislike'),
	(1, 2, 'like'),
	(2, 1, 'angry');

-- Пытаемся оставить еще одну реакцию на запись
INSERT INTO reactions VALUES (1, 'sad', 1); 

-- Пытаемся оставить реакцию на несуществующую запись
INSERT INTO reactions VALUES (5, 'like', 1); 

SELECT * FROM reactions;

-- DROP TABLE reactions;

/* 11. Создадим таблицу с репостами.
 * 
 * Сценарий: каждый пользователь может репостнуть запись у себя на странице.
 * 
 * Таблица включает поле с id записи, которую репостят, и связанное с полем id таблицы posts, пользовател (поле связано с users.id) 
 * и время репоста.
 * 
 * Так как одну запись могут репостить разные пользователи, но не более одного раза (связь многие к одному), 
 * то нет необходимости создавать поле id. Вместо него используем составной PRIMARY KEY. 
 * 
 */

CREATE TABLE reposts(
	post_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (post_id) REFERENCES posts (id),
	user_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users (id),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (post_id, user_id)
);

SELECT * FROM reposts;

-- DROP TABLE reposts;



