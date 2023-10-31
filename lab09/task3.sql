USE red_river_climbs;

 -- View top three route equippers from developed_climbs table
 SELECT climber_first_name, climber_last_name, COUNT(climb_id)
   FROM developed_climbs
        INNER JOIN climbers
        USING (climber_id)
        GROUP BY climber_id
        ORDER BY COUNT(climb_id) DESC
        LIMIT 3;

