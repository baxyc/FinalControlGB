/*8. Создать таблицы с иерархией из диаграммы в БД
9. Заполнить низкоуровневые таблицы именами(животных), командами
которые они выполняют и датами рождения
*/
DROP DATABASE IF EXISTS human_friends;
CREATE DATABASE human_friends;
USE human_friends;

DROP TABLE IF EXISTS animals;
CREATE TABLE animals (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    kind_animals VARCHAR(50)
);

INSERT INTO `animals` (`id`, `kind_animals`) values
(1, 'cat'),
(2, 'cat'),
(3, 'dog'),
(4, 'dog'),
(5, 'hamster'),
(6, 'hamster'),
(7, 'horse'),
(8, 'horse'),
(9, 'camel'),
(10, 'camel'),
(11, 'donkey'),
(12, 'donkey');

DROP TABLE IF EXISTS pets;
CREATE TABLE pets (
	pet_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `pets` (`pet_id`, `animal_id`) values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

DROP TABLE IF EXISTS pack_animals;
CREATE TABLE pack_animals (
	pack_animal_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);


INSERT INTO `pack_animals` (`pack_animal_id`, `animal_id`) values
(1, 7),
(2, 8),
(3, 9),
(4, 10),
(5, 11),
(6, 12);

DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
	cat_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `cats` (`cat_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 1, 'Барсик', 'сидеть: лежать', '2020-11-08'),
(2, 2, 'Том', 'сидеть: лежать', '2022-11-08');

DROP TABLE IF EXISTS dogs;
CREATE TABLE dogs (
	dog_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `dogs` (`dog_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 3, 'Шарик', 'сидеть: лежать', '2020-11-08'),
(2, 4, 'Джек', 'сидеть: лежать', '2022-11-08');

DROP TABLE IF EXISTS hamsters;
CREATE TABLE hamsters (
	hamster_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `hamsters` (`hamster_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 5, 'Стив', 'сидеть: лежать', '2022-11-08'),
(2, 6, 'Родж', 'сидеть: лежать', '2022-12-08');

DROP TABLE IF EXISTS horses;
CREATE TABLE horses (
	horse_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `horses` (`horse_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 7, 'Роза', 'сидеть: лежать', '2015-11-08'),
(2, 8, 'Белка', 'сидеть: лежать', '2021-12-08');

DROP TABLE IF EXISTS camels;
CREATE TABLE camels (
	camel_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `camels` (`camel_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 9, 'Сопатый', 'сидеть: лежать', '2016-11-08'),
(2, 10, 'Лохматый', 'сидеть: лежать', '2022-12-08');

DROP TABLE IF EXISTS donkeys;
CREATE TABLE donkeys (
	donkey_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	animal_id BIGINT UNSIGNED NOT NULL,
    name VARCHAR(50),
    commands TEXT,
    birthday DATE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

INSERT INTO `donkeys` (`donkey_id`, `animal_id`, `name`, `commands`, `birthday`) values
(1, 11, 'Иа', 'сидеть: лежать', '2018-11-08'),
(2, 12, 'Рав', 'сидеть: лежать', '2022-01-01');


/*Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой
питомник на зимовку. Объединить таблицы лошади, и ослы в одну таблицу.
*/
DELETE camels, pack_animals, animals FROM camels
JOIN pack_animals 
JOIN animals
WHERE camels.animal_id = pack_animals.animal_id AND
		camels.animal_id = animals.id;


SELECT horse_id, NULL AS donkey_id, animal_id, name, commands, birthday
FROM horses
UNION
SELECT NULL AS horse_id, donkey_id, animal_id, name, commands, birthday
FROM donkeys;

/*Создать новую таблицу “молодые животные” в которую попадут все
животные старше 1 года, но младше 3 лет и в отдельном столбце с точностью
до месяца подсчитать возраст животных в новой таблице*/
DROP TABLE IF EXISTS young_animals;		
CREATE TABLE young_animals
SELECT animals.*,
		cats.name,
		TIMESTAMPDIFF(MONTH, birthday, NOW()) AS age
FROM cats
LEFT JOIN animals ON animals.id = cats.animal_id
WHERE TIMESTAMPDIFF(MONTH, birthday, NOW()) < 37 AND TIMESTAMPDIFF(MONTH, birthday, NOW()) > 11
UNION
SELECT animals.*,
		dogs.name,
		TIMESTAMPDIFF(MONTH, birthday, NOW()) AS age
FROM dogs
LEFT JOIN animals ON animals.id = dogs.animal_id
WHERE TIMESTAMPDIFF(MONTH, birthday, NOW()) < 37 AND TIMESTAMPDIFF(MONTH, birthday, NOW()) > 11
UNION
SELECT animals.*,
		hamsters.name,
		TIMESTAMPDIFF(MONTH, birthday, NOW()) AS age
FROM hamsters
LEFT JOIN animals ON animals.id = hamsters.animal_id
WHERE TIMESTAMPDIFF(MONTH, birthday, NOW()) < 37 AND TIMESTAMPDIFF(MONTH, birthday, NOW()) > 11
UNION
SELECT animals.*,
		horses.name,
		TIMESTAMPDIFF(MONTH, birthday, NOW()) AS age
FROM horses
LEFT JOIN animals ON animals.id = horses.animal_id
WHERE TIMESTAMPDIFF(MONTH, birthday, NOW()) < 37 AND TIMESTAMPDIFF(MONTH, birthday, NOW()) > 11
UNION
SELECT animals.*,
		name,
		TIMESTAMPDIFF(MONTH, birthday, NOW()) AS age
FROM donkeys
LEFT JOIN animals ON animals.id = donkeys.animal_id
WHERE TIMESTAMPDIFF(MONTH, birthday, NOW()) < 37 AND TIMESTAMPDIFF(MONTH, birthday, NOW()) > 11;


/*Объединить все таблицы в одну, при этом сохраняя поля, указывающие на
прошлую принадлежность к старым таблицам.
*/
SELECT animals.id, cats.*, dogs.*, hamsters.*, horses.*, donkeys.*
FROM animals
LEFT JOIN cats ON animals.id = cats.animal_id
LEFT JOIN dogs ON animals.id = dogs.animal_id
LEFT JOIN hamsters ON animals.id = hamsters.animal_id
LEFT JOIN horses ON animals.id = horses.animal_id
LEFT JOIN donkeys ON animals.id = donkeys.animal_id;















