USE red_river_climbs;

-- Show the number of routes at each difficulty level in the database. 
-- If there are no routes at a given difficulty level, the output
-- should explicitly show 0.
SELECT grade_str AS 'Difficulty Level', COUNT(climb_id) AS 'Num Routes'
  FROM climb_grades
       LEFT OUTER JOIN climbs
       ON climb_grades.grade_id = climbs.climb_grade
       GROUP BY grade_str;
