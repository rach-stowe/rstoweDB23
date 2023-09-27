/*
Lab 03: Implementing a Database
Rachel Stowe
October 2, 2023
*/

/* Create carpet_store database and drop previous version if necessary */
  DROP DATABASE IF EXISTS carpet_store;
CREATE DATABASE carpet_store;
   USE carpet_store;

/* Create Carpet Countries table to store valid countries of origin for carpets */
CREATE TABLE Carpet_Countries (
    PRIMARY KEY (carpet_country),
    carpet_country  VARCHAR(64) NOT NULL
);

/* Create Carpet Styles table to store valid styles for carpets */
CREATE TABLE Carpet_Styles (
    PRIMARY KEY (carpet_style),
    carpet_style  VARCHAR(64) NOT NULL
);

/* Create Carpet Materials table to store valid materials for carpets */
CREATE TABLE Carpet_Materials (
    PRIMARY KEY (carpet_material),
    carpet_material  VARCHAR(64) NOT NULL
);

/* Create Carpets table to store information about all carpets that have been stocked in the store */
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
);

/* Create Customer States table to store valid two-letter state codes for customer addresses */
CREATE TABLE Customer_States (
    PRIMARY KEY (customer_state),
    customer_state  VARCHAR(2) NOT NULL
);

/* Create Customers table to store information about current and past customers at the store */
CREATE TABLE Customers (
    PRIMARY KEY (customer_id),
    FOREIGN KEY (customer_state) REFERENCES Customer_States(customer_state),
    customer_id                 INT unsigned    NOT NULL AUTO_INCREMENT,
    customer_first_name         VARCHAR(64)     NOT NULL,
    customer_last_name          VARCHAR(64)     NOT NULL,
    customer_street_address     VARCHAR(128)    NOT NULL, 
    customer_city               VARCHAR(64)     NOT NULL,
    customer_state              VARCHAR(2)      NOT NULL,
    customer_zip                VARCHAR(5)      NOT NULL,
    customer_phone              VARCHAR(10),
    customer_activity           VARCHAR(10)
);

/* Create Carpet Sales table to store information about each carpet sale */
CREATE TABLE Carpet_Sales (
    PRIMARY KEY (customer_id, carpet_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (carpet_id)   REFERENCES Carpets(carpet_id),
    customer_id     INT unsigned    NOT NULL,
    carpet_id       INT unsigned    NOT NULL,
    sale_date       DATE            NOT NULL,
    sale_price      FLOAT (10,2)    NOT NULL
);

/* Create Carpet Rentals table to store information about each carpet rental */
CREATE TABLE Carpet_Rentals (
    PRIMARY KEY (customer_id, carpet_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (carpet_id)   REFERENCES Carpets(carpet_id),
    customer_id             INT unsigned    NOT NULL,
    carpet_id               INT unsigned    NOT NULL,
    expected_return_date    DATE            NOT NULL,
    actual_return_date      DATE
);