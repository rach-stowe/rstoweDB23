USE red_river_climbs;

 -- View original developed_climbs table
 SELECT (climb_id), (climb_name), (developed_date)
   FROM developed_climbs
        INNER JOIN climbs
        USING (climb_id);

 -- View original climbs table
 SELECT (climb_id), (climb_name)
   FROM climbs;

-- Remove all routes from the DB which were equipped in the past year

-- Change the delimiter to create a multi-line procedure.
DELIMITER //

-- Create stored procedure to delete climbs
CREATE PROCEDURE delete_climbs()
BEGIN
    SET FOREIGN_KEY_CHECKS = FALSE;
    DELETE climbs FROM climbs 
        INNER JOIN developed_climbs 
        USING (climb_id) 
    WHERE developed_climbs.developed_date > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
    SET FOREIGN_KEY_CHECKS = TRUE;
END //

-- Change the delimiter back.
DELIMITER ;

-- Call stored procedure to delete climbs
CALL delete_climbs();

 -- View updated developed_climbs table
 SELECT (climb_id), (climb_name), (developed_date)
   FROM developed_climbs
        INNER JOIN climbs
        USING (climb_id);

 -- View updated climbs table
 SELECT (climb_id), (climb_name)
   FROM climbs;