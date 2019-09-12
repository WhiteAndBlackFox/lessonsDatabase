-- Удаляем БД если она есть и создаем заново
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

-- Удаляем таблицу и создаем её заново, если она есть
DROP TABLE IF EXISTS example.users;
/*
 * Таблица с пользователями
 * id - индетефикатор пользователей, не обязательное поле
 * name - имя пользователя, не обязательное поле, размер 255 символов
 * login - логин пользователя, обязательное поле, размер 255 символов
 * passwd - пароль пользователя, обязательное поле, не ограничен, т.к. могут использоваться разные методы шифрования
 * */
CREATE TABLE example.users (
	id SERIAL PRIMARY KEY COMMENT 'Индетефикатор пользователя',
	name VARCHAR(255) COMMENT 'Имя пользователя',
	login VARCHAR(255) UNIQUE NOT NULL COMMENT 'Логин пользователя',
	passwd TEXT NOT NULL COMMENT 'Пароль пользователя',
	KEY idx_name USING BTREE (name),
	KEY idx_login USING BTREE (login)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT = 'Таблица с пользователями';
