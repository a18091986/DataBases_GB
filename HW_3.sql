
-- 1. Проанализировать структуру БД vk, которую мы создали на занятии, 
-- и внести предложения по усовершенствованию (если такие идеи есть). 
-- Напишите пожалуйста, всё-ли понятно по структуре.
-- Доброго дня! По структуре вроде бы всё понятно - как обычно разбираться в созданном кем-то проще, чем 
-- придумывать самому, особенно если тебе ещё  и поясняют в процессе создания. 
-- В части улучшений: если говорить
-- о существующих таблицах, то особенно добавить нечего - разве что ввести дополнительные поля "на всякий случай".
-- например: в профайлы - интересы (для потенциального подключения в дальнейшем каких-то рекомендательных систем или 
-- рекламы), какие-то дополнительные данные для возможности интеграции с внешними сервисами (аля номер СТС для 
-- оповещения о штрафах ПДД :)). Дополнительно в обмен сообщениями добавить передачу файлов. 
 
-- 2. Добавить необходимую таблицу/таблицы для того, чтобы можно было использовать лайки для медиафайлов,
-- постов и пользователей.

DROP TABLE IF EXISTS posts;
CREATE TABLE posts (

	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX fk_posts_from_user_idx (from_user_id),
	CONSTRAINT fk_posts_users FOREIGN KEY (from_user_id) REFERENCES users (id)

);


DROP TABLE IF EXISTS type_of_likes;
CREATE TABLE type_of_likes(
	id SERIAL PRIMARY KEY,
	type_of_like varchar(45) NOT NULL UNIQUE -- like, dislike, etc
);


DROP TABLE IF EXISTS likes_to_users;
CREATE TABLE likes_to_users(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	type_of_like_id BIGINT UNSIGNED NOT NULL, 
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(from_user_id, to_user_id),
	INDEX fk_likes_to_users_type_of_like_idx (type_of_like_id),
	INDEX fk_likes_to_users_from_user_idx (from_user_id),
  	INDEX fk_likes_to_users_to_user_idx (to_user_id),
  	CONSTRAINT fk_likes_to_users_type_of_like FOREIGN KEY (type_of_like_id) REFERENCES type_of_likes (id),
  	CONSTRAINT fk_likes_to_users_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
  	CONSTRAINT fk_likes_to_users_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);

DROP TABLE IF EXISTS likes_to_media;

CREATE TABLE likes_to_media(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_media_id BIGINT UNSIGNED NOT NULL,
	type_of_like_id BIGINT UNSIGNED NOT NULL, 
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(from_user_id, to_media_id),
	INDEX fk_likes_to_media_type_of_like_idx (type_of_like_id),
	INDEX fk_likes_to_media_from_user_idx (from_user_id),
  	INDEX fk_likes_to_media_to_media_idx (to_media_id),
  	CONSTRAINT fk_likes_to_media_type_of_like FOREIGN KEY (type_of_like_id) REFERENCES type_of_likes (id),
  	CONSTRAINT fk_likes_to_media_user FOREIGN KEY (from_user_id) REFERENCES users (id),
  	CONSTRAINT fk_likes_to_media_media FOREIGN KEY (to_media_id) REFERENCES media (id)
);

DROP TABLE IF EXISTS likes_to_posts;

CREATE TABLE likes_to_posts(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_post_id BIGINT UNSIGNED NOT NULL,
	type_of_like_id BIGINT UNSIGNED NOT NULL, 
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(from_user_id, to_post_id),
	INDEX fk_likes_to_posts_type_of_like_idx (type_of_like_id),
	INDEX fk_likes_to_posts_from_user_idx (from_user_id),
  	INDEX fk_likes_to_posts_to_post_idx (to_post_id),
  	CONSTRAINT fk_likes_to_posts_type_of_like FOREIGN KEY (type_of_like_id) REFERENCES type_of_likes (id),
  	CONSTRAINT fk_likes_to_posts_user FOREIGN KEY (from_user_id) REFERENCES users (id),
  	CONSTRAINT fk_likes_to_posts_post FOREIGN KEY (to_post_id) REFERENCES posts (id)
);


