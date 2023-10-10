USE red_river_climbs;

-- Show the first and last names (as separate columns) of everyone who 
-- has developed a climb in the 'Miller Fork' Region. Each name should 
-- only be shown once.
SELECT climber_first_name AS 'First Name', climber_last_name AS 'Last Name'
  FROM developed_climbs
       INNER JOIN climbers
       USING (climber_id)
       INNER JOIN climbs
       USING (climb_id)
       INNER JOIN crags
       USING (crag_name)
       INNER JOIN regions
       USING (region_name)
       WHERE region_name = 'Miller Fork'
       GROUP BY climber_last_name;
