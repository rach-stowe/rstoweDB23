USE robo_rest_fall_2023;

INSERT INTO Dishes(DishName, DishPrice, DishWeightGrams)
VALUES ("Black Bean Burger", 11.99, 200),
       ("Fried Okra Poppers", 9.99, 100),
       ("Fries", 3.99, 50),
       ("Quesadilla", 5.99, 150);

INSERT INTO Franchises(FranchiseLocationLat, FranchiseLocationLon, FranchiseStreet, FranchiseCity, FranchiseState, FranchiseZIP)
VALUES (400, 400, "500 Rose Street", "Lexington", "KY", "40359"),
       (50, 100, "200 Rose Avenue", "Lexington", "KY", "40359");

INSERT INTO Customers(CustomerFirstName, CustomerLastName, CustomerEmail, CustomerDefaultLat, CustomerDefaultLong)
VALUES ("Rachel", "Stowe", "rachel.stowe@centre.edu", 200, 100),
       ("Rachel", "Stove", "rachel.stove@centre.edu", 100, 200),
       ("Rachael", "Stowe", "rachael.stowe@centre.edu", 100, 50),
       ("Rachael", "Stove", "rachael.stove@centre.edu", 50, 400);

INSERT INTO Drones(DroneCallsign, FranchiseID)
VALUES (12, 2),
       (30, 2),
       (25, 2),
       (40, 1),
       (2, 1),
       (7, 1);
