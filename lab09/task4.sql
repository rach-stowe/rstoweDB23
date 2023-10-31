USE red_river_climbs;

-- Replace null values within climbs table
UPDATE climbs
   SET climb_len_ft = " "
 WHERE climb_len_ft = NULL;

-- View each climb's name, grade, length, and crag, and if applicable,
-- its first climber  and/or first equipper
SELECT climb_name AS 'Name', 
       grade_str AS 'Grade',
       climb_len_ft AS 'Length (ft)' 
  FROM climbs
       INNER JOIN climb_grades
       ON climb_grades.grade_id = climbs.climb_grade;

