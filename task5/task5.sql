/*

-- Задание 1.1 --
Пусть в таблице users поля created_at и updated_at оказались незаполненными.
Заполните их текущими датой и временем.

*/

UPDATE users SET created_at = CURRENT_TIMESTAMPWHERE created_at IS NULL;

UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE updated_at IS NULL;

/*

-- Задание 1.2 --
Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

*/

UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'), updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;

/*

-- Задание 1.3 --
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.

*/

-- 1 вариант --
SELECT * FROM storehouses_products sp
ORDER BY sp.value = 0, sp.value ASC;

-- 2 вариант --
SELECT * FROM storehouses_products sp WHERE sp.value > 0
UNION ALL
SELECT * FROM storehouses_products sp WHERE sp.value = 0;

/*

-- Задание 1.4 --
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

*/

SELECT * FROM users u WHERE MONTHNAME(u.created_at) IN ('may', 'october')

/*

-- Задание 1.5 --
Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

*/

-- 1 вариант --
SELECT * FROM catalogs c 
    WHERE c.id IN (5, 1, 2) ORDER BY;

-- 2 вариант --
SELECT * FROM catalogs c 
    WHERE c.id IN (5, 1, 2) 
ORDER BY c.id = 5 DESC, c.id = 1 DESC, c.id = 2 DESC;

/*

-- Задание 2.1 --
Подсчитайте средний возраст пользователей в таблице users.

*/

SELECT AVG((YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d'))) FROM users;

/*

-- Задание 2.2 --
Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

*/

SELECT DAYNAME(u.created_at) as week_name, COUNT(*) FROM users u GROUP BY week_name;

/*

-- Задание 2.3 --
Подсчитайте произведение чисел в столбце таблицы.

*/

WITH T AS (SELECT * FROM (SELECT (-2) UNION ALL SELECT (-3) UNION ALL SELECT (4) UNION ALL SELECT (-5)) X(value)), P AS ( 
	SELECT SUM(CASE WHEN value < 0 THEN 1 ELSE 0 END) neg,
		SUM(CASE WHEN value > 0 THEN 1 ELSE 0 END) pos,
		COUNT(*) total FROM T)
	SELECT CASE WHEN total <> pos + neg THEN 0 ELSE (CASE WHEN neg % 2 = 1 THEN -1 ELSE +1 END) *round(exp(SUM(LOG(abs(value)))))
END product 
FROM T,P
WHERE value <> 0 
GROUP BY neg, pos, total;
