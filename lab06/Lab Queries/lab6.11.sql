USE red_river_climbs;

/*
Show the maximum grade established by each developer. Each 
developer should appear only once.
*/
SELECT climber_first_name AS 'First Name', climber_last_name AS 'Last Name',
       grade_str AS 'Maximum Grade'
  FROM climbers
       INNER JOIN developed_climbs
       USING (climber_id)
       INNER JOIN climbs
       USING (climb_id)
       INNER JOIN climb_grades
       ON climb_grades.grade_id = climbs.climb_grade
       WHERE climbs.climb_grade = 
             (SELECT MAX(climb_grade)
               FROM climbs
               INNER JOIN developed_climbs AS C2
               USING (climb_id)
               INNER JOIN climbers
               USING (climber_id)
               WHERE developed_climbs.climber_id = climbers.climber_id AND 
                     C2.climber_id = developed_climbs.climber_id);
