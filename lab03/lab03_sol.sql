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
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (consumer_id) REFERENCES consumers(consumer_id),
    movie_id       INT unsigned    NOT NULL,
    consumer_id    INT unsigned    NOT NULL,
    rating_date    DATETIME        NOT NULL,
    num_stars      INT unsigned    NOT NULL
);

/* Insert data into movies table */
INSERT INTO movies (movie_title, release_date, movie_genre)
VALUES ('The Hunt for Red October',        '1990-03-02', 'Acton, Adventure, Thriller'),
       ('Lady Bird',                       '2017-12-01', 'Comedy, Drama'),
       ('Inception',                       '2010-08-16', 'Acton, Adventure, Science Fiction'),
       ('Monty Python and the Holy Grail', '1975-04-03', 'Comedy');

/* Insert data into consumers table */
INSERT INTO consumers (consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip_code)
VALUES ('Toru',   'Okada',    '800 Glenridge Ave', 'Hobart',     'IN', '46343'),
       ('Kumiko', 'Okada',    '864 NW Bohemia St', 'Vincetown',  'NJ', '08088'),
       ('Noboru', 'Wataya',   '342 Joy Ridge St',  'Hermitage',  'TN', '37076'),
       ('May',    'Kasahara', '5 Kent Rd',         'East Haven', 'CT', '06512');

/* Insert data into ratings table */
INSERT INTO ratings (movie_id, consumer_id, rating_date, num_stars)
VALUES (1, 1, '2010-09-02 10:54:19', 4),
       (1, 3, '2012-08-05 15:00:01', 3),
       (1, 4, '2016-10-02 23:58:12', 1),
       (2, 3, '2017-03-27 00:12:48', 2),
       (2, 4, '2018-08-02 00:54:42', 4);

/* Show the formats of the three tables */
SHOW CREATE TABLE movies;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE ratings;

/* Display all information from the three tables */
SELECT * FROM movies;
SELECT * FROM consumers;
SELECT * FROM ratings;

/* Generate a ratings report */
 SELECT consumer_first_name, consumer_last_name, movie_title, num_stars FROM movies
NATURAL JOIN ratings
NATURAL JOIN consumers;

/* 
The movies table has a major design flaw, because the genre field is multivalued.
*/

/* REDESIGNED TABLES */

/* Create movie_ratings database and drop previous version if necessary */
  DROP DATABASE IF EXISTS movie_ratings;
CREATE DATABASE movie_ratings;
   USE movie_ratings;

/* Create movies table to hold movie ID, title, and release date */
CREATE TABLE movies (
    PRIMARY KEY (movie_id),
    movie_id       INT unsigned    NOT NULL AUTO_INCREMENT,
    movie_title    VARCHAR(128)    NOT NULL,
    release_date   DATE            NOT NULL
);

/* Create genres table to hold the genre(s) of each movie */
CREATE TABLE genres (
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    movie_id      INT unsigned  NOT NULL,
    movie_genre   VARCHAR(64)   NOT NULL
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
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (consumer_id) REFERENCES consumers(consumer_id),
    movie_id       INT unsigned    NOT NULL,
    consumer_id    INT unsigned    NOT NULL,
    rating_date    DATETIME        NOT NULL,
    num_stars      INT unsigned    NOT NULL
);

/* Insert data into movies table */
INSERT INTO movies (movie_title, release_date)
VALUES ('The Hunt for Red October',        '1990-03-02'),
       ('Lady Bird',                       '2017-12-01'),
       ('Inception',                       '2010-08-16'),
       ('Monty Python and the Holy Grail', '1975-04-03');

/* Insert data into genres table */
INSERT INTO genres (movie_id, movie_genre)
VALUES (1, 'Acton'),
       (1, 'Adventure'),
       (1, 'Thriller'),
       (2, 'Comedy'),
       (2, 'Drama'),
       (3, 'Acton'),
       (3, 'Adventure'),
       (3, 'Science Fiction'),
       (4, 'Comedy');

/* Insert data into consumers table */
INSERT INTO consumers (consumer_first_name, consumer_last_name, consumer_address, consumer_city, consumer_state, consumer_zip_code)
VALUES ('Toru',   'Okada',    '800 Glenridge Ave', 'Hobart',     'IN', '46343'),
       ('Kumiko', 'Okada',    '864 NW Bohemia St', 'Vincetown',  'NJ', '08088'),
       ('Noboru', 'Wataya',   '342 Joy Ridge St',  'Hermitage',  'TN', '37076'),
       ('May',    'Kasahara', '5 Kent Rd',         'East Haven', 'CT', '06512');

/* Insert data into ratings table */
INSERT INTO ratings (movie_id, consumer_id, rating_date, num_stars)
VALUES (1, 1, '2010-09-02 10:54:19', 4),
       (1, 3, '2012-08-05 15:00:01', 3),
       (1, 4, '2016-10-02 23:58:12', 1),
       (2, 3, '2017-03-27 00:12:48', 2),
       (2, 4, '2018-08-02 00:54:42', 4);

/* Show the formats of the four tables */
SHOW CREATE TABLE movies;
SHOW CREATE TABLE genres;
SHOW CREATE TABLE consumers;
SHOW CREATE TABLE ratings;

/* Display all information from the four tables */
SELECT * FROM movies;
SELECT * FROM genres;
SELECT * FROM consumers;
SELECT * FROM ratings;

/* Generate a ratings report */
 SELECT consumer_first_name, consumer_last_name, movie_title, num_stars FROM movies
NATURAL JOIN ratings
NATURAL JOIN consumers;

/* Generate a genres report */
 SELECT movie_title, movie_genre FROM movies
NATURAL JOIN genres;