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
    carpet_country  VARCHAR(64) DEFAULT 'unknown'
);

/* Create Carpet Styles table to store valid styles for carpets */
CREATE TABLE Carpet_Styles (
    PRIMARY KEY (carpet_style),
    carpet_style  VARCHAR(64) DEFAULT 'unknown'
);

/* Create Carpet Materials table to store valid materials for carpets */
CREATE TABLE Carpet_Materials (
    PRIMARY KEY (carpet_material),
    carpet_material  VARCHAR(64) DEFAULT 'unknown'
);

/* Create Carpets table to store information about all carpets that have been stocked in the store */
CREATE TABLE Carpets (
    PRIMARY KEY (carpet_id),
    FOREIGN KEY (carpet_country)  REFERENCES Carpet_Countries(carpet_country) ON DELETE SET DEFAULT,
    FOREIGN KEY (carpet_style)    REFERENCES Carpet_Styles(carpet_style) ON DELETE SET DEFAULT,
    FOREIGN KEY (carpet_material) REFERENCES Carpet_Materials(carpet_material) ON DELETE SET DEFAULT,
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
    customer_phone              VARCHAR(10)     UNIQUE,
    customer_activity           BOOLEAN         DEFAULT TRUE
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
    rental_date             DATE            NOT NULL,
    expected_return_date    DATE            NOT NULL,
    actual_return_date      DATE
);

/* Fill validation tables with data */
INSERT INTO Carpet_Countries(carpet_country)
VALUES ('Turkey'),
       ('Iran'),
       ('India'),
       ('Afghanistan');

INSERT INTO Carpet_Styles(carpet_style)
VALUES ('Ushak'),
       ('Tabriz'),
       ('Agra');

INSERT INTO Carpet_Materials(carpet_material)
VALUES ('Wool'),
       ('Cotton'),
       ('Silk');

INSERT INTO Customer_States(customer_state)
VALUES ('AL'),
       ('AK'),
       ('AZ'),
       ('AR'),
       ('CA'),
       ('CO'),
       ('CT'),
       ('DE'),
       ('FL'),
       ('GA'),
       ('HI'),
       ('ID'),
       ('IL'),
       ('IN'),
       ('IA'),
       ('KS'),
       ('KY'),
       ('LA'),
       ('ME'),
       ('MD'),
       ('MA'),
       ('MI'),
       ('MN'),
       ('MS'),
       ('MO'),
       ('MT'),
       ('NE'),
       ('NV'),
       ('NH'),
       ('NJ'),
       ('NM'),
       ('NY'),
       ('NC'),
       ('ND'),
       ('OH'),
       ('OK'),
       ('OR'),
       ('PA'),
       ('RI'),
       ('SC'),
       ('SD'),
       ('TN'),
       ('TX'),
       ('UT'),
       ('VT'),
       ('VA'),
       ('WA'),
       ('WV'),
       ('WI'),
       ('WY');

/* Fill Carpets table */
INSERT INTO Carpets (carpet_country, carpet_style, carpet_material, carpet_width, carpet_length, 
                    carpet_year, carpet_purchase_price, carpet_date_acquired, carpet_markup_percentage)
VALUES ('Turkey', 'Ushak',  'Wool', 5,  7,  1925, 625,   20170406, 100),
       ('Iran',   'Tabriz', 'Silk', 10, 14, 1910, 28000, 20170406, 75),
       ('India',  'Agra',   'Wool', 8,  10, 2017, 1200,  20170615, 100),
       ('India',  'Agra',   'Wool', 4,  6,  2017, 450,   20170615, 120);

/* Fill Customers table */
INSERT INTO Customers (customer_first_name, customer_last_name, customer_street_address, customer_city, 
                      customer_state, customer_zip, customer_phone)
VALUES ('Akira',    'Ingram',  '68 Country Drive',       'Roseville',      'MI', '48066', '9262526716'),
       ('Meredith', 'Spencer', '9044 Piper Lane',        'North Royalton', 'OH', '44133', '8175305994'),
       ('Marco',    'Page',    '747 East Harrison Lane', 'Atlanta',        'GA', '30303', '5887996535'),
       ('Sandra',   'Page',    '47 East Harrison Lane',  'Atlanta',        'GA', '30303', '9976972666'),
       ('Gloria',   'Gomez',   '78 Corona Road',         'Fullerton',      'CA', '92831',  NULL),
       ('Bria',     'Le',      '386 Silver Spear Court', 'Coraopolis',     'PA', '15108',  NULL);

/* Fill Carpet Sales table */
INSERT INTO Carpet_Sales (customer_id, carpet_id, sale_date, sale_price)
VALUES (5, 1, 20171214, 990),
       (6, 3, 20171224, 2400);

/* Fill Carpet Rentals table */
INSERT INTO Carpet_Rentals (customer_id, carpet_id, rental_date, expected_return_date, actual_return_date)
VALUES (2, 2, 20171224, 20171226, 20171226);

/* Display Carpets table */
SELECT carpet_id AS 'Inventory #',
       carpet_country AS 'Country',
       carpet_style AS 'Style',
       carpet_material AS 'Material',
       carpet_year AS 'Year of Origin',
       carpet_width AS 'Width',
       carpet_length AS 'Length',
       carpet_purchase_price AS 'Purchase Price',
       carpet_date_acquired AS 'Date Acquired',
       carpet_markup_percentage AS 'Markup %',
       (carpet_purchase_price + carpet_purchase_price * carpet_markup_percentage / 100) AS 'List Price'
  FROM Carpets;
    
/* Display Customers table */
SELECT customer_first_name AS 'First Name',
       customer_last_name AS 'Last Name', 
       customer_street_address AS 'Street Address', 
       customer_city AS 'City',
       customer_state AS 'State',
       customer_zip AS 'Zip Code',
       customer_phone AS 'Mobile Phone'
  FROM Customers; 

/* Display Carpet Sales table */
SELECT customer_first_name AS 'First Name',
       customer_last_name AS 'Last Name',
       customer_street_address AS 'Street Address', 
       customer_city AS 'City',
       customer_state AS 'State',
       customer_zip AS 'Zip Code',
       carpet_id AS 'Inventory #',
       carpet_country AS 'Country',
       carpet_style AS 'Style',
       carpet_material AS 'Material',
       carpet_year AS 'Year of Origin',
       carpet_width AS 'Width',
       carpet_length AS 'Length',
       sale_date AS 'Sale Date',
       sale_price AS 'Sale Price',
       carpet_purchase_price AS 'Original Cost',
       (sale_price - carpet_purchase_price) AS 'Net on Sale'
  FROM Carpet_Sales
       LEFT OUTER JOIN Carpets
       USING (carpet_id)
       LEFT OUTER JOIN Customers
       USING (customer_id);

/* Display Carpet Rentals table */
SELECT customer_first_name AS 'First Name',
       customer_last_name AS 'Last Name',
       customer_street_address AS 'Street Address', 
       customer_city AS 'City',
       customer_state AS 'State',
       customer_zip AS 'Zip Code',
       carpet_id AS 'Inventory #',
       carpet_country AS 'Country',
       carpet_style AS 'Style',
       carpet_material AS 'Material',
       carpet_year AS 'Year of Origin',
       carpet_width AS 'Width',
       carpet_length AS 'Length',
       rental_date AS 'Rental Date',
       expected_return_date AS 'Expected Return Date',
       actual_return_date AS 'Actual Return Date'   
  FROM Carpet_Rentals
       LEFT OUTER JOIN Carpets
       USING (carpet_id)
       LEFT OUTER JOIN Customers
       USING (customer_id);