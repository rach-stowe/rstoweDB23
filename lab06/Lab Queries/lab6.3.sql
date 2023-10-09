USE red_river_climbs;

-- Show the name and grade of all sport climbs at the "Slab City" crag.
SELECT climb_name AS 'Climb Name', grade_str AS 'Grade'
  FROM sport_climbs
       INNER JOIN climbs
       USING (climb_id)
       INNER JOIN climb_grades
       ON (climb_grades.grade_id = climbs.climb_grade)
       WHERE (crag_name = 'Slab City');