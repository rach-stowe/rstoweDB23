/*
Lab 03: Implementing a Database
Rachel Stowe
October 2, 2023
*/

/* Create carpet_store database and drop previous version if necessary */
  DROP DATABASE IF EXISTS carpet_store;
CREATE DATABASE carpet_store;
   USE carpet_store;

/* Create Carpets table to store information about the carpets in stock */
CREATE TABLE Carpets (
    PRIMARY KEY (carpet_id),
    FOREIGN KEY (carpet_country)  REFERENCES Carpet_Countries(carpet_country),
    FOREIGN KEY (carpet_style)    REFERENCES Carpet_Styles(carpet_style),
    FOREIGN KEY (carpet_material) REFERENCES Carpet_Materials(carpet_material),
    carpet_id                   INT unsigned    NOT NULL AUTO_INCREMENT,
    carpet_country              VARCHAR(64)     NOT NULL,
    carpet_style                VARCHAR(64)     NOT NULL,
    carpet_material             VARCHAR(64)     NOT NULL,
    carpet_year                 INT unsigned    NOT NULL,
    carpet_width                FLOAT (10,2)    NOT NULL,
    carpet_length               FLOAT (10,2)    NOT NULL,
    carpet_purchase_price       FLOAT (10,2)    NOT NULL,
    carpet_date_acquired        DATE            NOT NULL,
    carpet_markup_percentage    FLOAT (10,2)    NOT NULL
)