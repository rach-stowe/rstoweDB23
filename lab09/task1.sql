USE red_river_climbs;

 -- View original climbs table
 SELECT (climb_id), (climb_name), (grade_str)
   FROM climbs
        INNER JOIN climb_grades
        ON climbs.climb_grade = climb_grades.grade_id;

-- Change all routes graded "5.10" to "5.10a"
UPDATE climb_grades
   SET grade_str = "5.10a"
 WHERE grade_str = "5.10";

 -- View updated climbs table
 SELECT (climb_id), (climb_name), (grade_str)
   FROM climbs
        INNER JOIN climb_grades
        ON climbs.climb_grade = climb_grades.grade_id;