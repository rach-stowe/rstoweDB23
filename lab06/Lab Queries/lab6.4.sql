USE red_river_climbs;

-- Show the name and grade of every traditional (trad) climb in the database.
SELECT climb_name AS 'Name', grade_str AS 'Grade'
  FROM trad_climbs
       INNER JOIN climbs
       USING (climb_id)
       INNER JOIN climb_grades
       ON (climb_grades.grade_id = climbs.climb_grade);