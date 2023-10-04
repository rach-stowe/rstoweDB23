USE red_river_climbs;

-- Show the name and location(crag name) of every climb in the database.
SELECT climb_name AS 'Name', crag_name AS 'Location'
  FROM climbs;