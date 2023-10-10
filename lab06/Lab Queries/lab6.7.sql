USE red_river_climbs;

/* Show the climb name, number of bolts, and the nicknames 
(climber_handle) for all climbers in the FA party for every 
sport climb in the database. Each climb should have only one 
row in the output. */

SELECT climb_name AS 'Climb Name', climb_bolts AS 'Num Bolts', 
       GROUP_CONCAT(climber_handle) AS 'Nicknames'
  FROM first_ascents
       INNER JOIN sport_climbs
       USING (climb_id)
       INNER JOIN climbs
       USING (climb_id)
       INNER JOIN climbers
       USING (climber_id)
       GROUP BY (climb_id);
