/*
-- Задание 1 --
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине. 

(Примечание) Так же добавлен вывод количество заказов.
*/

SELECT u.name, COUNT(o.id) AS count_order FROM orders o
LEFT JOIN  users u ON u.id = o.user_id
GROUP BY u.name

/*
-- Задание 2 --
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT * FROM products p
LEFT JOIN catalogs c ON c.id = p.catalog_id

/*
-- Задание 3 --
(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.
*/

SELECT c_from.name, c_to.name FROM flights f
LEFT JOIN cities c_from ON c_from.label = f.`from`
LEFT JOIN cities c_to ON c_to.label = f.`to`