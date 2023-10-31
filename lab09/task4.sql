USE red_river_climbs;

-- Replace null values within climbs table
UPDATE climbs
   SET climb_len_ft = " "
 WHERE climb_len_ft = NULL;

-- Temporary subqueries
CREATE TEMPORARY TABLE first_climbs AS
SELECT climb_name,
       grade_str,
       climb_len_ft,
       crag_name,
       GROUP_CONCAT(DISTINCT CONCAT(climber_first_name, ' ', climber_last_name)) AS 'first_ascent',
       climber_id,
       climb_id
  FROM climbs
       INNER JOIN climb_grades
       ON climb_grades.grade_id = climbs.climb_grade
       LEFT OUTER JOIN first_ascents
       USING (climb_id)
       LEFT OUTER JOIN climbers
       USING (climber_id)
       GROUP BY climb_name; 

SELECT * FROM first_climbs;

-- View each climb's name, grade, length, and crag, and if applicable,
-- its first climber  and/or first equipper
SELECT climb_name AS 'Name', 
       grade_str AS 'Grade',
       climb_len_ft AS 'Length (ft)',
       crag_name AS 'Crag',
       first_ascent AS 'First ascent by',
       GROUP_CONCAT(DISTINCT CONCAT(climber_first_name, ' ', climber_last_name)) AS 'Equipped by'
  FROM first_climbs
       LEFT OUTER JOIN developed_climbs
       USING (climb_id)
       LEFT OUTER JOIN climbers
       USING (developed_climbs(climber_id))
       GROUP BY climb_name;

DROP TABLE first_climbs;
