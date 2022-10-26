-- ii. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке

SELECT DISTINCT first_name FROM users ORDER BY first_name; 

-- iii. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). 
--      Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)

SELECT * FROM profiles;
ALTER TABLE profiles ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
UPDATE profiles 
SET is_active = FALSE WHERE TIMESTAMPDIFF(YEAR, birthday, curdate()) < 18;

-- iv. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)

SELECT * FROM messages;
DELETE FROM messages WHERE created_at > now(); 