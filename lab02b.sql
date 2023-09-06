/*
  Lab 02: MariaDB Tutorial
  CSC 362 
  Rachel Stowe
  September 6, 2023
*/

/* Create the school database (dropping the previous version if necessary) */
DROP DATABASE IF EXISTS school;
CREATE DATABASE school;
USE school;

/* Create table to hold instructor IDs, names, and phone numbers */
CREATE TABLE instructors (
    PRIMARY KEY (instructor_id),
    instructor_id       INT unsigned NOT NULL AUTO_INCREMENT, -- instructor ID
    inst_first_name     VARCHAR(20), -- instructor first name
    inst_last_name      VARCHAR(20), -- instructor last name
    campus_phone        VARCHAR(20) -- instructor campus phone
);

/* Insert instructor data into table */
INSERT INTO instructors (inst_first_name, inst_last_name, campus_phone)
VALUES  ('Kira', 'Bentley', '363-9948'),
        ('Timothy', 'Ennis', '527-4992'),
        ('Shannon', 'Black', '336-5992'),
        ('Estela', 'Rosales', '322-6992');

/* Display instructor table by selecting all data */
SELECT * from instructors;

/* End of file lab02a.sql */
