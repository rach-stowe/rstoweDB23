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
    release_date   VARCHAR(10),
    movie_genre    VARCHAR(64)
);

/* Create consumers table to hold consumer id, first and last name, and address information */
CREATE TABLE consumers (
    PRIMARY KEY (consumer_id),
    consumer_id             INT unsigned    NOT NULL AUTO_INCREMENT,
    consumer_first_name     VARCHAR(64)     NOT NULL,
    consumer_last_name      VARCHAR(64)     NOT NULL,
    consumer_address        VARCHAR(128),
    consumer_city           VARCHAR(64),
    consumer_state          VARCHAR(64),
    consumer_zip_code       VARCHAR(5)
);

/* Create ratings table to hold movie ID, consumer ID, rating date, and number of stars in a rating */
CREATE TABLE ratings (
    FOREIGN KEY (movie_id) REFERENCES (movies(movie_id)),
    FOREIGN KEY (consumer_id) REFERENCES (consumers(consumer_id)),
    movie_id       INT unsigned    NOT NULL,
    consumer_id    INT unsigned    NOT NULL,
    rating_date    VARCHAR(128)    NOT NULL,
    num_stars      VARCHAR(10)
);