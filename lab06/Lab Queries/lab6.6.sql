USE red_river_climbs;

-- What climbing grades can be found on land owned by "John and Elizabeth Muir"?
SELECT grade_str AS 'Climb Grade'
  FROM climbs
       INNER JOIN climb_grades
       ON (climb_grades.grade_id = climbs.climb_grade)
       INNER JOIN crags 
       USING (crag_name)
       INNER JOIN regions
       USING (region_name)
       INNER JOIN owners
       USING (owner_name)
       WHERE owner_name = 'John and Elizabeth Muir'
       GROUP BY grade_id;