SHOW tables;
SELECT * FROM users;
DESCRIBE users;

INSERT INTO users (first_name, last_name, email, phone, password_hash) 
VALUES ('Pavel', 'Pavlov', 'pp@mail.com', '11111111111', '81dc9bdb52d04dc20036dbd8313ed055');

INSERT IGNORE INTO users (first_name, last_name, email, phone) 
VALUES ('Ivan', 'Ivanov', 'ii@mail.com', '11111111111'),
	   ('Aleksey', 'Alekseev', 'aa@mail.com', '12342134214'),
	   ('Kirill', 'Kirillov', 'kir@mail.com', '15344535324'),
	   ('Константин', 'Константинов', 'kos18@mail.com', '33333333333'),
	   ('Алена', 'Вадимова', 'av@mail.com', '234532532235'),
	   ('Нина', 'Павлова', 'np@mail.com', '234523453245'),
	   ('Армен', 'Арутюнян', 've@mail.com', '3523535345'),
	   ('Григорий', 'Ivanov', 'gi@mail.com', '32532453252345'),
	   ('Ivan', 'Ivanov', 'vi@mail.com', '12342124312'),
	   ('Петр', 'Ivanov', 'ii@mail.com', '2356346464');

SHOW tables;
SELECT * FROM profiles;
TRUNCATE TABLE profiles;
DESCRIBE profiles;

INSERT IGNORE INTO profiles (user_id, gender, birthday, photo_id, city, country) 
VALUES ('1', 'm', '1993-01-12', '1', 'Moscow', 'Russia'),
	   ('2', 'm', '1969-01-01', '2', 'Moscow', 'Russia'),
	   ('3', 'm', '1997-03-05', '3', 'Moscow', 'Russia'),
	   ('4', 'm', '2021-07-02', '4', 'Moscow', 'Russia'),
	   ('5', 'm', '1989-02-06', '5', 'Moscow', 'Russia'),
	   ('6', 'm', '1993-05-15', '6', 'Moscow', 'Russia'),
	   ('7', 'm', '1995-03-13', '7', 'Moscow', 'Russia'),
	   ('8', 'f', '2017-10-01', '8', 'Moscow', 'Russia'),
	   ('9', 'f', '1993-12-31', '9', 'Moscow', 'Russia'),
	   ('10', 'm', '2020-04-01', '10', 'Moscow', 'Russia'),
	   ('11', 'm', '2003-06-20', '11', 'Moscow', 'Russia'),
	   ('12', 'm', '1999-11-11', '12', 'Moscow', 'Russia');
	   
SHOW tables;
SELECT * FROM messages; -- WHERE txt LIKE 'future%';
-- TRUNCATE TABLE messages;
DESCRIBE messages;

INSERT IGNORE INTO messages (from_user_id, to_user_id, txt) 
VALUES ('3', '5', 'Hi'),
	   ('5', '3', 'Hello'),
	   ('4', '11', 'How are u'),
	   ('11', '4', 'ok'),
	   ('8', '10', '))'),
	   ('12', '3', 'call me'),
	   ('3', '5', '))'),
	   ('6', '5', 'Hi'),
	   ('7', '8', 'Hi'),
	   ('8', '1', 'kuku'),
	   ('2', '12', 'sorry'),
	   ('3', '5', 'Hi'),
	   ('11', '10', 'need help'),
	   ('10', '11', 'no problem'),
	   ('3', '5', 'Hi'),
	   ('3', '8', 'Hi'),
	   ('3', '2', 'Hi'),
	   ('6', '4', 'Hi'),
	   ('9', '5', 'Hi');

INSERT IGNORE INTO messages (from_user_id, to_user_id, txt, created_at) 
VALUES ('3', '5', 'future1', '2022-10-10 00:00:01'),
	   ('5', '3', 'future2', '2022-11-11 00:00:01'),
	   ('4', '11', 'future3', '2022-12-12 00:00:01');
	   
SHOW tables;
SELECT * FROM friend_requests; 
-- TRUNCATE TABLE messages;
DESCRIBE friend_requests;

INSERT IGNORE INTO friend_requests (from_user_id, to_user_id, accepted) 
VALUES ('3', '5', '1'),
	   ('5', '3', '1'),
	   ('4', '11', '1'),
	   ('11', '4', '1'),
	   ('8', '10', '1'),
	   ('12', '3', '1'),
	   ('6', '5', '1'),
	   ('7', '8', '1'),
	   ('8', '1', '1'),
	   ('2', '12', '1'),
	   ('11', '10', '1'),
	   ('10', '11', '1'),
	   ('3', '8', '0'),
	   ('3', '2', '0'),
	   ('6', '4', '0'),
	   ('9', '5', '0');

SHOW tables;
SELECT * FROM communities; 
-- TRUNCATE TABLE messages;
DESCRIBE communities;

INSERT IGNORE INTO communities (name, description, admin_id) 
VALUES ('Comun1', 'Comun1', '1'),
	   ('Comun2', 'Comun2', '2'),
	   ('Comun3', 'Comun3', '3'),
	   ('Comun4', 'Comun4', '4'),
	   ('Comun5', 'Comun5', '5'),
	   ('Comun6', 'Comun6', '6'),
	   ('Comun7', 'Comun7', '7'),
	   ('Comun8', 'Comun8', '1'),
	   ('Comun9', 'Comun9', '2'),
	   ('Comun10', 'Comun10', '7'),
	   ('Comun11', 'Comun11', '1');
	   
SHOW tables;
SELECT * FROM communities_users; 
-- TRUNCATE TABLE messages;
DESCRIBE communities_users;

INSERT IGNORE INTO communities_users (community_id, user_id) 
VALUES ('1', '1'), ('1', '2'), ('1', '5'), ('1', '11'),
	   ('2', '2'), ('1', '1'), ('1', '5'), ('1', '7'),
	   ('3', '3'), ('3', '12'), ('3', '4'), ('3', '12'),
	   ('4', '1'), ('4', '2'), ('4', '4'), ('4', '11'),
	   ('5', '3'), ('5', '5'), ('5', '5'), ('5', '12'),
	   ('6', '6'), ('6', '4'), ('6', '10'), ('6', '9'),
	   ('7', '1'), ('7', '2'), ('7', '5'), ('7', '11'),
	   ('1', '3'), ('1', '8'), 
	   ('2', '12'),
	   ('8', '8'),
	   ('9', '9'),
	   ('10', '10'),
	   ('11', '11'),
	   ('12', '12'), ('12', '1');
	   
SHOW tables;
SELECT * FROM media; 
-- TRUNCATE TABLE messages;
DESCRIBE media;

INSERT IGNORE INTO media (user_id, media_types_id, file_name, file_size) 
VALUES ('1', '1', '1.jpeg', '100'),
	   ('2', '1', '2.jpeg', '100'),
	   ('3', '1', '3.jpeg', '100'),
	   ('4', '1', '4.jpeg', '100'),
	   ('5', '1', '5.jpeg', '100'),
	   ('6', '1', '6.jpeg', '100'),
	   ('7', '1', '7.jpeg', '100'),
	   ('8', '1', '8.jpeg', '100'),
	   ('9', '1', '9.jpeg', '100'),
	   ('10', '1', '10.jpeg', '100'),
	   ('1', '1', '11.jpeg', '100'),
	   ('1', '1', '12.jpeg', '100');

SHOW tables;
SELECT * FROM posts; 
-- TRUNCATE TABLE messages;
DESCRIBE posts;

INSERT IGNORE INTO posts (author_id, txt, media_1, parent_id) 
VALUES ('1', 'Posts1', '1.jpeg', DEFAULT),
	   ('1', 'Posts2', '11.jpeg', DEFAULT),
	   ('2', 'Posts3', '2.jpeg', DEFAULT),
	   ('3', 'Posts4', '3.jpeg', DEFAULT),
	   ('4', 'Posts5', '4.jpeg', DEFAULT),
	   ('5', 'Posts6', '5.jpeg', DEFAULT),
	   ('6', 'Posts7', '6.jpeg', DEFAULT),
	   ('7', 'Posts8', '7.jpeg', DEFAULT),
	   ('8', 'Posts9', '8.jpeg', DEFAULT),
	   ('9', 'Posts10', '9.jpeg', DEFAULT),
	   ('10', 'Posts11', DEFAULT, DEFAULT),
	   ('11', 'Posts11', DEFAULT, DEFAULT),
	   ('12', 'Posts11', DEFAULT, DEFAULT),
	   ('13', 'Posts11', DEFAULT, DEFAULT),
	   ('14', 'Posts11', DEFAULT, DEFAULT);

INSERT IGNORE INTO posts (author_id, txt, media_1, parent_id) 
VALUES ('1', 'Posts1', '12.jpeg', '6'),
	   ('1', 'Posts2', DEFAULT, '8'),
	   ('2', 'Posts3', DEFAULT, '4'),
	   ('3', 'Posts4', DEFAULT, '14');

SHOW tables;
SELECT * FROM reposts; 
-- TRUNCATE TABLE messages;
DESCRIBE reposts;

INSERT IGNORE INTO reposts (post_id, user_id) 
VALUES ('1', '1'), ('1', '2'), ('1', '5'), ('1', '11'),
	   ('2', '2'), ('1', '1'), ('1', '5'), ('1', '7'),
	   ('3', '3'), ('3', '12'), ('3', '4'), ('3', '12'),
	   ('4', '1'), ('4', '2'), ('4', '4'), ('4', '11'),
	   ('5', '3'), ('5', '5'), ('5', '5'), ('5', '12'),
	   ('6', '6'), ('6', '4'), ('6', '10'), ('6', '9'),
	   ('7', '1'), ('7', '2'), ('7', '5'), ('7', '11'),
	   ('1', '3'), ('1', '8'), 
	   ('2', '12'),
	   ('8', '8'),
	   ('9', '9'),
	   ('10', '10'),
	   ('11', '11'),
	   ('12', '12'), ('12', '1');

SHOW tables;
SELECT * FROM reactions; 
-- TRUNCATE TABLE messages;
DESCRIBE reactions;

INSERT IGNORE INTO reactions (post_id, user_id, reaction_type) 
VALUES ('1', '1', 'like'), ('1', '2', 'like'), ('1', '5', 'smile'), ('1', '11', 'smile'),
	   ('2', '2', 'like'), ('1', '1', 'smile'), ('1', '5', 'like'), ('1', '7', 'smile'),
	   ('3', '3', 'laugh'), ('3', '12', 'smile'), ('3', '4', 'like'), ('3', '12', 'like'),
	   ('4', '1', 'smile'), ('4', '2', 'like'), ('4', '4', 'laugh'), ('4', '11', 'smile'),
	   ('5', '3', 'laugh'), ('5', '5', 'like'), ('5', '5', 'like'), ('5', '12', 'smile'),
	   ('6', '6', 'laugh'), ('6', '4', 'smile'), ('6', '10', 'like'), ('6', '9', 'angry'),
	   ('7', '1', 'angry'), ('7', '2', 'angry'), ('7', '5', 'like'), ('7', '11', 'angry'),
	   ('1', '3', 'sad'), ('1', '8', 'like'), 
	   ('2', '12', 'laugh'),
	   ('8', '8', 'like'),
	   ('9', '9', 'angry'),
	   ('10', '10', 'smile'),
	   ('11', '11', 'angry'),
	   ('12', '12', 'laugh'), ('12', '1', 'smile');