DROP DATABASE IF EXISTS readme;

CREATE DATABASE IF NOT EXISTS readme
    DEFAULT CHARACTER SET utf8
    DEFAULT COLLATE utf8_general_ci;

USE readme;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    login VARCHAR(128) NOT NULL UNIQUE,
    email VARCHAR(128) NOT NULL UNIQUE,
    avatar VARCHAR(255),
    password VARCHAR(255) NOT NULL
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS content_types
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name ENUM ('Текст', 'Цитата', 'Картинка', 'Видео', 'Ссылка') default 'Текст',
    icon_class ENUM ('text', 'quote', 'picture', 'video', 'link') default 'text'
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS hashtags
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(128) NOT NULL UNIQUE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS posts
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    created_at DATETIME NOT NULL,
    content TEXT,
    content_type INT,
    author INT,
    image VARCHAR(255),
    video VARCHAR(255),
    site VARCHAR(255),
    num_views INT DEFAULT 0,

    INDEX author_ind (author),
    FOREIGN KEY (author)
        REFERENCES users(id)
        ON DELETE CASCADE,

    INDEX content_type_ind (content_type),
    FOREIGN KEY (content_type)
        REFERENCES content_types(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS posts_hashtags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    hashtag_id INT NOT NULL,

    INDEX post_id_ind (post_id),
    FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    INDEX hashtag_id_ind (hashtag_id),
    FOREIGN KEY (hashtag_id)
        REFERENCES hashtags(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    content TEXT NOT NULL,
    author INT NOT NULL,
    post_id INT NOT NULL,

    INDEX author_id_ind (author),
    FOREIGN KEY (author)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    INDEX post_id_ind (post_id),
    FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,

    INDEX user_id_ind (user_id),
    FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    INDEX post_id_ind (post_id),
    FOREIGN KEY (post_id)
        REFERENCES posts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS subscriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subscriber INT NOT NULL,
    author INT NOT NULL,

    INDEX subscriber_ind (subscriber),
    FOREIGN KEY (subscriber)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    INDEX author_id_ind (author),
    FOREIGN KEY (author)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME NOT NULL,
    content TEXT NOT NULL,
    sender INT NOT NULL,
    recipient INT NOT NULL,

    INDEX sender_ind (sender),
    FOREIGN KEY (sender)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    INDEX recipient_ind (recipient),
    FOREIGN KEY (recipient)
        REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=INNODB;


