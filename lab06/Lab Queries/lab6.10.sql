USE red_river_climbs;

/* Show the grade strings and names of all the routes at each 
   difficulty level. If there are no routes at a given difficulty 
   level, that level need not appear in the output. */
SELECT grade_str AS 'Grade', GROUP_CONCAT(climb_name) AS 'Route Names'
  FROM climbs
       INNER JOIN climb_grades
       ON climb_grades.grade_id = climbs.climb_grade
       GROUP BY grade_id;
