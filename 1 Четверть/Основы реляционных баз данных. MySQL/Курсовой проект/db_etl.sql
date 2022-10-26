DROP DATABASE IF EXISTS db_etl;

CREATE DATABASE IF NOT EXISTS db_etl;

USE db_etl;

/* 1. Таблица с данными о сотрудниках лаборатории.*/

DROP TABLE IF EXISTS personnel;
CREATE TABLE personnel(
	id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
	surname VARCHAR(25)  ,
	name VARCHAR(25) NOT NULL,
	patronymic VARCHAR(25) NOT NULL,
	position VARCHAR(25) NOT NULL,
	UNIQUE INDEX  fullname (surname, name, patronymic) 
	);

INSERT IGNORE INTO personnel (surname, name, patronymic, position)
VALUES ("Вечер", "Андрей", "Суренович", "Начальник лаборатории"),
	("Губарь", "Александр", "Михайлович", "Инженер НиИ 1 категории"),
	("Шарков", "Кирилл", "Федорович", "Инженер НиИ 1 категории"),
	("Плескацевич", "Павел", "Сергеевич", "Инженер НиИ 1 категории"),
	("Овчинников", "Алексей", "Анатольевич", "Инженер НиИ 2 категории"),
	("Гаврильчик", "Иван", "Александрович", "Инженер НиИ 2 категории"),
	("Зарихта", "Константин", "Сергеевич", "Инженер НиИ"),
	("Тарасевич", "Алексей", "Николаевич", "Инженер НиИ");

/*2. Таблица с данными о исредствах измерений лаборатории.*/

DROP TABLE IF EXISTS instruments;
CREATE TABLE instruments(
	id SERIAL,
	type VARCHAR(50) NOT NULL,
	model VARCHAR(25),
	serial_num VARCHAR(25) NOT NULL,
	calibration_sertificate VARCHAR(25),
	calibration_date DATE  NOT NULL DEFAULT (CURRENT_DATE),
	calibration_validity DATE NOT NULL DEFAULT (calibration_date + INTERVAL 1 YEAR),
	UNIQUE KEY item (model, serial_num),
	INDEX (type, model)
);

INSERT IGNORE INTO instruments (type, model, serial_num, calibration_date, calibration_validity)
VALUES ('Мегаомметр', 'E6-31', '12345', DEFAULT, DEFAULT),
	('Мегаомметр', 'E6-31', '245436', '2022-03-12', DEFAULT),
	('Мегаомметр', 'E6-32', '3452124', '2021-12-14', DEFAULT),
	('Аппарат для испытания диэлектриков', 'АИД-70М', '31727', '2021-12-14', DEFAULT),
	('Микроомметр', 'MIKO-9A', 'A342', '2022-01-14', DEFAULT);

/* 3. Таблица с данными о проектах, в которых участвует лаборатория.*/

DROP TABLE IF EXISTS projects;
CREATE TABLE projects(
	id SERIAL,
	customer VARCHAR(100) NOT NULL,
	title TEXT NOT NULL,
	address VARCHAR(100) NOT NULL,
	contract_num VARCHAR (15),
	contract_date DATETIME,
	INDEX (customer),
	INDEX (contract_num)
);

INSERT IGNORE INTO projects (customer, title, address)
VALUES ('Минские электрические сети', 'Реконструкци ПС 110 кВ "Острошицкий городок"', 'Минский р-н'),
	('Могилевские электрические сети', 'Строительство цифровой ПС 330 кВ "Могилев 330"', 'Могилевский р-н');

/*4. Таблица с регистрационными данными протоколов испытаний*/

/*TODO: сделать триггеры для проверки сквозной нумерации по дате создания и для недопущения протоколов из будущего.*/

DROP TABLE IF EXISTS reports;
CREATE TABLE reports(
	num INT UNSIGNED NOT NULL DEFAULT 0,
	creation_date DATE NOT NULL DEFAULT (CURRENT_DATE),
	creation_year YEAR NOT NULL, 
	title VARCHAR(50),
	project_id BIGINT UNSIGNED NOT NULL,
	edited_by INT UNSIGNED NOT NULL,
	checked_by INT UNSIGNED NOT NULL DEFAULT 1,
	FOREIGN KEY (project_id) REFERENCES projects (id),
	FOREIGN KEY (edited_by) REFERENCES personnel (id),
	FOREIGN KEY (checked_by) REFERENCES personnel (id),
	PRIMARY KEY pk (num, creation_year),
	INDEX (creation_year, num)
);

DELIMITER //

DROP TRIGGER IF EXISTS autoincrement_mod//
CREATE TRIGGER autoincrement_mod 
BEFORE INSERT ON reports
FOR EACH ROW 
BEGIN 
	DECLARE bigest_num INT;
	SET NEW.creation_year = YEAR(NEW.creation_date);
	IF NEW.num = 0 THEN 
	BEGIN 
		SET bigest_num = COALESCE((SELECT MAX(num) FROM reports WHERE creation_year = NEW.creation_year), 0);
		SET NEW.num = bigest_num + 1;
	END;
	END IF;
END//

DELIMITER ;

DELIMITER //

DROP TRIGGER IF EXISTS end_to_end_numbering_insert//
CREATE TRIGGER end_to_end_numbering_insert BEFORE INSERT ON reports
FOR EACH ROW
BEGIN 
	DECLARE previous_date, next_date DATE;
	SET previous_date = (SELECT MAX(creation_date) FROM reports 
					 WHERE creation_year = NEW.creation_year AND num < NEW.num);
	IF previous_date IS NOT NULL AND NEW.creation_date < previous_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с меньшим номером уже зарегистрирован на более позднюю дату.";
	END IF;			
	SET next_date = (SELECT MIN(creation_date) FROM reports 
				 WHERE creation_year = NEW.creation_year AND num > NEW.num);
	IF next_date IS NOT NULL AND NEW.creation_date > next_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с большим номером уже зарегистрирован на более раннюю дату.";
	END IF;	
END//

DROP TRIGGER IF EXISTS end_to_end_numbering_update//
CREATE TRIGGER end_to_end_numbering_update BEFORE UPDATE ON reports
FOR EACH ROW
BEGIN 
	DECLARE previous_date, next_date DATE;
	SET previous_date = (SELECT MAX(creation_date) FROM reports 
					 WHERE creation_year = NEW.creation_year AND num < NEW.num);
	IF previous_date IS NOT NULL AND NEW.creation_date < previous_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с меньшим номером уже зарегистрирован на более позднюю дату.";
	END IF;			
	SET next_date = (SELECT MIN(creation_date) FROM reports 
				 WHERE creation_year = NEW.creation_year AND num > NEW.num);
	IF next_date IS NOT NULL AND NEW.creation_date > next_date
	THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Ошибка! Протокол с большим номером уже зарегистрирован на более раннюю дату.";
	END IF;	
END//

DELIMITER ;

-- truncate reports; 

INSERT INTO reports (num, creation_date, title, project_id, edited_by)
VALUES ('25', '2022-04-28', 'Протокол испытаний трансформатора Т-1', 1, 3),
	(DEFAULT, '2022-04-28', 'Протокол испытаний силового кабеля', 1, 3),
	('041', '2022-05-01', 'Протокол испытаний трансформатора Т-21', 2, 4),
	(DEFAULT, '2022-05-01', 'Протокол испытаний трансформатора Т-22', 2, 4),
	(DEFAULT, '2022-05-01', 'Протокол испытаний трансформатора Т-23', 2, 4),
	(DEFAULT, '2022-05-01', 'Протокол испытаний трансформатора Т-2', 1, 3);

/*
INSERT INTO reports (num, creation_date, title, project_id, edited_by)
VALUES ('045', '2022-04-27', 'Протокол испытаний трансформатора Т-1', 1, 3);

UPDATE reports SET num = '21' WHERE num = '41';
*/


/*5. Таблица-каталог с категориями проверяемого оборудования.*/

DROP TABLE IF EXISTS equipment_categories;
CREATE TABLE equipment_categories(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50) NOT NULL UNIQUE
);

INSERT IGNORE INTO equipment_categories (title)
VALUES ('Трансформаторы 2-х обмоточные'), 
	('Трансформаторы 3-х обмоточные'),
	('Автотрансформаторы'),
	('Силовие кабели');

/*6. Таблица с наименованием проверяемого оборудования.*/

DROP TABLE IF EXISTS equipment;
CREATE TABLE equipment(
	id SERIAL,
	title VARCHAR(50) NOT NULL,
	category_id INT UNSIGNED,
	project_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (category_id) REFERENCES equipment_categories (id),
	FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE,
	INDEX (project_id),
	INDEX (category_id)
);

INSERT INTO equipment (title, category_id, project_id)
VALUES ('Т-1', '1', '1'), ('Т-2', '1', '1'), ('Кабельный ввод', '2', '1'),
	('Т-21', '1', '2'), ('Т-22', '1', '2'),  ('Т-23', '1', '2');

/*7. Таблица с атрибутами проверяемого оборудования по категоряим.*/

/*TODO: добавить чекбоксы для аттрибутов.*/

DROP TABLE IF EXISTS equipment_attributes;
CREATE TABLE equipment_attributes(
	id SERIAL,
	category_id INT UNSIGNED,
	title  VARCHAR(50) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES equipment_categories (id) ON DELETE CASCADE,
	UNIQUE KEY (category_id, title)
)

INSERT INTO equipment_attributes (category_id, title)
VALUES ('1', 'Марка'), ('1', 'Мощность'), ('1', 'Напряжение ВН'), ('1', 'Напряжение НН'),
	('2', 'Марка'), ('2', 'Мощность'), ('2', 'Напряжение ВН'), ('2', 'Напряжение СН'), ('2', 'Напряжение НН'),
	('4', 'Марка'), ('4', 'Сечение'), ('4', 'Длина'), ('4', 'Направление');

/*8. Таблица с характеристиками проверяемого оборудования.*/

DROP TABLE IF EXISTS equipment_values;
CREATE TABLE equipment_values(
	equipment_id BIGINT UNSIGNED NOT NULL,
	attribute_id BIGINT UNSIGNED NOT NULL,
	value VARCHAR(50),
	PRIMARY KEY (equipment_id, attribute_id),
	FOREIGN KEY (equipment_id) REFERENCES equipment (id) ON DELETE CASCADE,
	FOREIGN KEY (attribute_id) REFERENCES equipment_attributes (id) ON DELETE CASCADE
);

INSERT INTO equipment_values (equipment_id, attribute_id, value)
VALUES ('1', '1', 'ТДН-16000/110'), ('1', '2', '16000'), ('1', '3', '110'), ('1', '4', '10'), 
	('2', '1', 'ТДН-16000/110'), ('2', '2', '16000'), ('2', '3', '110'), ('2', '4', '10'), 
	('3', '10', 'ПВуПнг'), ('3', '11', '3х95/15'), ('3', '12', '3.4'), ('3', '13', 'Т-1 - ЗРУ-10. Ячейка №8'), 
	('4', '1', 'ТМ-1000/10'), ('4', '2', '1000'), ('4', '3', '10'), ('4', '4', '0.4'), 
	('5', '1', 'ТМ-1000/10'), ('5', '2', '1000'), ('5', '3', '10'), ('5', '4', '0.4'), 
	('6', '1', 'ТМ-1000/10'), ('6', '2', '1000'), ('6', '3', '10'), ('6', '4', '0.4'); 

/*Запрос на получение характеристик оборудования с id=1.*/

SELECT ea.title, ev.value FROM equipment_values ev
JOIN equipment_attributes ea ON ev.attribute_id = ea.id
WHERE equipment_id = 2;

/*9. Таблица-каталог с наименованием испытаний, выполняемых лабораторией.*/

DROP TABLE IF EXISTS tests;
CREATE TABLE tests(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	test VARCHAR(100) NOT NULL,
	parameter VARCHAR(100) NOT NULL,
	dimension VARCHAR(10),
	UNIQUE KEY (test, parameter)
);

INSERT INTO tests (test, parameter, dimension)
VALUES ('Измерение сопротивления изоляции', 'R15', 'МОм'),
	('Измерение сопротивления изоляции', 'R60', 'МОм'),
	('Измерение сопротивления обмотки постоянному току', 'Rобм', 'МОм'),
	('Измерение тока утечки', 'Iут', 'мА');

/*10. Таблица с результатами выполненных измерений.*/

/*TODO: добавить триггер на проверку соответствия средства измерения выполняемому испытанию.*/

DROP TABLE IF EXISTS results;
CREATE TABLE results(
	id SERIAL,
	equipment_id BIGINT UNSIGNED NOT NULL,
	test_id INT UNSIGNED NOT NULL,
	instrument_id BIGINT UNSIGNED NOT NULL,
	mode VARCHAR(25) NOT NULL DEFAULT '',
	result FLOAT UNSIGNED NOT NULL,
	dimension VARCHAR(10),
	performed_on DATE NOT NULL DEFAULT (CURRENT_DATE),
	remark VARCHAR(250) NOT NULL DEFAULT '', 
	UNIQUE KEY (equipment_id, test_id, mode, performed_on, remark), -- если измерение повторялось несколько раз в течение дня, необходимо сделать пометку в remark для идентификации
	FOREIGN KEY (equipment_id) REFERENCES equipment(id) ON DELETE CASCADE,
	FOREIGN KEY (test_id) REFERENCES tests(id),
	FOREIGN KEY (instrument_id) REFERENCES instruments(id)
);

DELIMITER //

CREATE TRIGGER result_demension BEFORE INSERT ON results
FOR EACH ROW 
BEGIN 
	IF NEW.dimension IS NULL THEN 
		SET NEW.dimension = (SELECT dimension FROM tests WHERE id = NEW.test_id);
	END IF;
END//

DELIMITER ;

INSERT IGNORE INTO results (equipment_id, test_id, instrument_id, mode, result, performed_on)
VALUES ('1', '1', '1', 'ВН - НН+Бак', '800', '2022-04-27'), ('1', '2', '1', 'ВН - НН+Бак', '1200', '2022-04-27'),
	('1', '1', '1', 'НН - ВН+Бак', '600', '2022-04-27'), ('1', '2', '1', 'НН - ВН+Бак', '1000', '2022-04-27'),
	('1', '3', '5', 'ВН. АВ', '1230', '2022-04-27'), ('1', '3', '5', 'ВН. ВС', '1231', '2022-04-27'), ('1', '3', '5', 'ВН. СА', '1225', '2022-04-27'),
	('1', '3', '5', 'НН. ab', '130', '2022-04-27'), ('1', '3', '5', 'НН. bc', '126', '2022-04-27'), ('1', '3', '5', 'НН. ca', '125', '2022-04-27'),
	('2', '1', '1', 'ВН - НН+Бак', '950', '2022-04-30'), ('2', '2', '1', 'ВН - НН+Бак', '1800', '2022-04-30'),
	('2', '1', '1', 'НН - ВН+Бак', '500', '2022-04-30'), ('2', '2', '1', 'НН - ВН+Бак', '1000', '2022-04-30'),
	('2', '3', '5', 'ВН. АВ', '1232', '2022-04-30'), ('2', '3', '5', 'ВН. ВС', '1231', '2022-04-30'), ('2', '3', '5', 'ВН. СА', '1226', '2022-04-30'),
	('2', '3', '5', 'НН. ab', '131', '2022-04-30'), ('2', '3', '5', 'НН. bc', '129', '2022-04-30'), ('2', '3', '5', 'НН. ca', '126', '2022-04-30'),
	('3', '1', '3', 'Фаза А', '630', '2022-04-27'), ('3', '4', '4', 'Фаза А', '1.2', '2022-04-27'),
	('3', '1', '3', 'Фаза B', '720', '2022-04-27'), ('3', '4', '4', 'Фаза B', '1.1', '2022-04-27'),
	('3', '1', '3', 'Фаза C', '660', '2022-04-27'), ('3', '4', '4', 'Фаза C', '1.1', '2022-04-27');

/*Запрос на получение всех измерений, выполненных для оборудования с id=1*/

SELECT t.test, r.mode, t.parameter, r.result, r.dimension FROM results r
JOIN tests t ON r.test_id = t.id 
WHERE equipment_id = 3
ORDER BY t.test, r.mode;

/*11. Таблица с данными о том, кто из сотрудников участвовал в получении результатов.*/

DROP TABLE IF EXISTS participants;
CREATE TABLE participants(
	results_id BIGINT UNSIGNED NOT NULL,
	personnel_id INT UNSIGNED NOT NULL,
	PRIMARY KEY (results_id, personnel_id),
	FOREIGN KEY (results_id) REFERENCES results (id) ON DELETE CASCADE,
	FOREIGN KEY (personnel_id) REFERENCES personnel (id),
	INDEX (results_id)
);

INSERT INTO participants (results_id, personnel_id)
VALUES ('1', '3'), ('1', '5'), ('2', '3'), ('2', '5'), ('3', '3'), ('3', '5'), ('4', '3'), ('4', '5'),
	('5', '3'), ('5', '5'), ('6', '3'), ('6', '5'), ('7', '3'), ('7', '5'), ('8', '3'), ('8', '5'),
	('9', '3'), ('9', '5'), ('10', '3'), ('10', '5'), ('11', '3'), ('11', '5'), ('12', '3'), ('12', '5'),
	('13', '3'), ('13', '5'), ('14', '3'), ('14', '5'), ('15', '3'), ('15', '5'), ('16', '3'), ('16', '5'),
	('17', '3'), ('17', '5'), ('18', '3'), ('18', '5'), ('19', '3'), ('19', '5'), ('20', '3'), ('20', '5'),
	('21', '4'), ('21', '7'), ('22', '4'), ('22', '7'), ('23', '4'), ('23', '7'), ('24', '4'), ('24', '7'), 
	('25', '4'), ('25', '7'), ('26', '4'), ('26', '7');

/*12. Таблица с данными о том, какие результаты включаются в тот или иной протокол.*/

DROP TABLE IF EXISTS report_results;
CREATE TABLE report_results(
	report_num INT UNSIGNED NOT NULL,
	results_id BIGINT UNSIGNED NOT NULL,
	UNIQUE KEY (report_num, results_id),
	FOREIGN KEY (report_num) REFERENCES reports (num) ON DELETE CASCADE,	
	FOREIGN KEY (results_id) REFERENCES results (id),
	INDEX (report_num)
);

INSERT INTO report_results (report_num, results_id)
VALUES ('25', '1'), ('25', '2'), ('25', '3'), ('25', '4'), ('25', '5'), 
	('25', '6'), ('25', '7'), ('25', '8'), ('25', '9'), ('25', '10'), 
	('26', '21'), ('26', '22'), ('26', '23'), ('26', '24'), ('26', '25'), ('26', '26'), 
	('44', '11'), ('44', '12'), ('44', '13'), ('44', '14'), ('44', '15'), 
	('44', '16'), ('44', '17'), ('44', '18'), ('44', '19'), ('44', '20');

/*Запрос на получение всех результатов, которые необходимо внести в протокол num = 25*/

SELECT t.test, r.mode, t.parameter, r.result, r.dimension 
FROM results r
JOIN tests t ON r.test_id = t.id 
JOIN report_results rr ON r.id = rr.results_id 
WHERE rr.report_num = 25
ORDER BY t.test, r.mode;

CREATE OR REPLACE VIEW report_results_view AS 
SELECT rr.report_num, t.test, r.mode, t.parameter, r.result, r.dimension 
FROM results r, tests t, report_results rr
WHERE r.test_id = t.id AND r.id = rr.results_id
ORDER BY rr.report_num, t.test, r.mode;

SELECT test, mode, parameter, result, dimension 
FROM (SELECT * FROM report_results_view HAVING report_num = 25) AS rrv;

/*Запрос на получение средств измерений, использованных для получения результатов, внесенных в протокол num = 25.*/

SELECT DISTINCT i.type, i.model, i.serial_num, i.calibration_validity  
FROM results r
JOIN report_results rr ON r.id = rr.results_id
JOIN instruments i ON r.instrument_id = i.id 
WHERE rr.report_num = 25;

CREATE OR REPLACE VIEW report_instruments_view AS 
SELECT DISTINCT rr.report_num, i.type, i.model, i.serial_num, i.calibration_validity  
FROM results r, report_results rr, instruments i
WHERE r.id = rr.results_id AND r.instrument_id = i.id;

SELECT DISTINCT type, model, serial_num, calibration_validity
FROM (SELECT * FROM report_instruments_view HAVING report_num = 25) AS riv;

/*Запрос на получение сотрудников, участвовавших в получении результатов, внесенных в протокол num = 25.*/

SELECT DISTINCT 
	CONCAT(p2.surname, ' ', SUBSTRING(p2.name, 1, 1), '.', SUBSTRING(p2.patronymic, 1, 1), '.') AS name,
	p2.position
FROM results r
JOIN report_results rr ON r.id = rr.results_id
JOIN participants p ON r.id = p.results_id
JOIN personnel p2 ON p2.id = p.personnel_id 
WHERE rr.report_num = 25;

CREATE OR REPLACE VIEW report_personnel_view AS 
SELECT DISTINCT 
	rr.report_num,
	CONCAT(p2.surname, ' ', SUBSTRING(p2.name, 1, 1), '.', SUBSTRING(p2.patronymic, 1, 1), '.') AS name,
	p2.position
FROM results r, report_results rr, participants p, personnel p2
WHERE r.id = rr.results_id AND r.id = p.results_id AND p2.id = p.personnel_id;

SELECT DISTINCT name, position
FROM (SELECT * FROM report_personnel_view HAVING report_num = 25) AS riv;

/*Представление отображающее выборку измерений, выполненных сотрудником по его id*/

CREATE OR REPLACE ALGORITHM = MERGE VIEW results_by_personnel_view AS
SELECT r.*, p.personnel_id FROM results r, participants p 
WHERE r.id = p.results_id;

SELECT * FROM results_by_personnel_view WHERE personnel_id = 5;
UPDATE results_by_personnel_view SET equipment_id = 1 WHERE id = 1;
-- truncate instruments ;
