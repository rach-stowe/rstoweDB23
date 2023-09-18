/*
Lab 3: Tables & Fields in SQL
Rachel Stowe
September 18, 2023
*/

/* Create movie_ratings database and drop previous version if necessary */
  DROP DATABASE IF EXISTS movie_ratings;
CREATE DATABASE movie_ratings;
   USE movie_ratings;

/* Create movies table to hold movie ID, title, release date, and genre */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id       INT unsigned    NOT NULL AUTO_INCREMENT,
    movie_title    VARCHAR(128)    NOT NULL,
    release_date   DATE            NOT NULL,
    movie_genre    VARCHAR(64)     NOT NULL
);

/* Create consumers table to hold consumer id, first and last name, and address information */
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id             INT unsigned    NOT NULL AUTO_INCREMENT,
    consumer_first_name     VARCHAR(64)     NOT NULL,
    consumer_last_name      VARCHAR(64)     NOT NULL,
    consumer_address        VARCHAR(128)    NOT NULL,
    consumer_city           VARCHAR(64)     NOT NULL,
    consumer_state          VARCHAR(2)      NOT NULL,
    consumer_zip_code       VARCHAR(5)      NOT NULL
);

/* Create ratings table to hold movie ID, consumer ID, rating date, and number of stars in a rating */
CREATE TABLE ratings (
    FOREIGN KEY (movie_id) REFERENCES (movies(movie_id)),
    FOREIGN KEY (consumer_id) REFERENCES (consumers(consumer_id)),
    movie_id       INT unsigned    NOT NULL,
    consumer_id    INT unsigned    NOT NULL,
    rating_date    DATETIME        NOT NULL,
    num_stars      INT unsigned    NOT NULL
);

/* Insert data into the three tables */
INSERT INTO movies (movie_title, release_date, genre)
VALUES ('The Hunt for Red October',        '1990-03-02', 'Acton, Adventure, Thriller'),
       ('Lady Bird',                       '2017-12-01', 'Comedy, Drama'),
       ('Inception',                       '2010-08-16', 'Acton, Adventure, Science Fiction'),
       ('Monty Python and the Holy Grail', '1975-04-03', 'Comedy');

INSERT INTO consumers (consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip_code)
VALUES ('Toru',   'Okada',    '800 Glenridge Ave', 'Hobart',     'IN', '46343'),
       ('Kumiko', 'Okada',    '864 NW Bohemia St', 'Vincetown',  'NJ', '08088'),
       ('Noboru', 'Wataya',   '342 Joy Ridge St',  'Hermitage',  'TN', '37076'),
       ('May',    'Kasahara', '5 Kent Rd',         'East Haven', 'CT', '06512');

INSERT INTO ratings (movie_id, consumer_id, rating_date, num_stars)
VALUES (1, 1, '2010-09-02 10:54:19', 4),
       (1, 3, '2012-08-05 15:00:01', 3),
       (1, 4, '2016-10-02 23:58:12', 1),
       (2, 3, '2017-03-27 00:12:48', 2),
       (2, 4, '2018-08-02 00:54:42', 4);

SHOW CREATE TABLE movies;
SELECT * from movies;