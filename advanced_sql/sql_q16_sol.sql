-- Write a SQL query to find referees and the number of matches they worked in each
-- venue

SELECT rm.referee_id, rm.referee_name, ven.venue_name
FROM referee_mast AS rm
LEFT JOIN 
(
	SELECT DISTINCT mm.referee_id, sv.venue_name
    FROM match_mast AS mm
    INNER JOIN soccer_venue AS sv ON mm.venue_id = sv.venue_id
) AS ven
ON rm.referee_id = ven.referee_id
ORDER BY rm.referee_name, ven.venue_name;
