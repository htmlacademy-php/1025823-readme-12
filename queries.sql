USE readme;

# список типов контента для поста;
INSERT INTO content_types (name, icon_class)
VALUES
	('Текст', 'text'),
	('Цитата', 'quote'),
	('Картинка', 'picture'),
	('Видео', 'video'),
	('Ссылка', 'link');

# придумайте пару пользователей;
INSERT INTO users (created_at, login, email, avatar, password)
VALUES
	('2020-11-07 17:58:45', 'victor', 'victor@mail.ru', 'victor.png', md5('123')),
	('2020-11-07 17:58:45', 'larisa', 'larisa@mail.ru', 'larisa.png', md5('123')),
	('2020-11-06 16:44:11', 'vladik', 'vladik@mail.ru', 'vladik.png', md5('345'));

# существующий список постов.
INSERT INTO posts (title, created_at, content, content_type_id, user_id, image, video, site)
VALUES
	('Цитата', '2020-01-07 17:58:45',
	'Мы в жизни любим только раз, а после ищем лишь похожих',
	'2', '2', 'userpic-larisa-small.jpg', NULL, 'http://larisa.ru'),
	('Очарование гор', '2020-02-16 16:44:11' ,
	 'Сложно побывать в горах и в них не влюбиться. Такой вид отдыха очень емкий: всего за неделю можно полностью переключиться, испытать «позитивный стресс», очистить голову и испытать себя. Тот, кто смог взойти на настоящую вершину, будет совсем по-другому смотреть на рабочие неурядицы, работать в группе и подходить к решению задач. Горы приучают к ответственности. При этом, чтобы заняться альпинизмом, каких-то экстраординарных способностей не требуется.',
	 '1', '3', 'userpic.jpg', NULL, NULL),
	('Игра престолов', '2020-03-22 11:55:09' ,
	'Не могу дождаться начала финального сезона своего любимого сериала!',
	'1', '3', 'userpic.jpg',  NULL, NULL),
	('Наконец, обработал фотки!', '2020-04-05 09:21:25' ,
	'rock-medium.jpg',
	'3', '1', 'userpic-mark.jpg', NULL, 'http://victor.ru'),
	('Моя мечта', '2020-04-21 12:11:33' ,
	 'coast-medium.jpg',
	 '3', '2', 'userpic-larisa-small.jpg', NULL, 'http://larisa.ru'),
	('Лучшие курсы', '2020-06-12 22:05:27' ,
	'www.htmlacademy.ru',
	'5', '3', 'userpic.jpg', NULL, NULL);

# придумайте пару комментариев к разным постам;
INSERT INTO  comments (created_at, content, user_id, post_id)
VALUES
    ('2020-01-15 16:34:12', 'Это лучший пост', 2, 1),
    ('2020-03-27 17:12:56', 'Очень мне это нравится', 1, 3);

# получить список постов с сортировкой по популярности и вместе с именами авторов и типом контента;
SELECT p.title AS Title, p.created_at AS Date, p.content AS Content, u.login AS Username, ct.name AS 'Content Type'
FROM posts p
INNER JOIN users u ON p.user_id = u.id
INNER JOIN content_types ct on p.content_type_id = ct.id
ORDER BY p.num_views;

# получить список постов для конкретного пользователя;
SELECT p.title AS Title, p.created_at AS Date, p.content AS Content
FROM posts p
WHERE user_id = 1;

# получить список комментариев для одного поста, в комментариях должен быть логин пользователя;
SELECT c.created_at AS Date, c.content AS Comment, u.login AS Username
FROM comments c
INNER JOIN users u on c.user_id = u.id
WHERE post_id = 1;

# добавить лайк к посту;
INSERT INTO likes (user_id, post_id)
VALUES (1, 1);

# подписаться на пользователя.
INSERT INTO subscriptions (subscriber, user_id)
VALUES (1, 2);
