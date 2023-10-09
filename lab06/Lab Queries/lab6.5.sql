USE red_river_climbs;

-- Shown the name, grade, length, crag, and region of every climb graded "5.9".
SELECT climb_name AS 'Climb Name', grade_str AS 'Grade', 
       climb_len_ft AS 'Length', crag_name AS 'Crag', region_name AS 'Region'
  FROM climbs
       INNER JOIN climb_grades
       ON (climb_grades.grade_id = climbs.climb_grade)
       INNER JOIN crags
       USING (crag_name)
       INNER JOIN regions
       USING (region_name)
       WHERE grade_str = '5.9'; 