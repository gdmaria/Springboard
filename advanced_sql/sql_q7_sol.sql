-- Write a SQL query to find all the venues where matches with penalty shootouts were
-- played.

SELECT DISTINCT venue_id
FROM match_mast
WHERE match_no IN
(
	SELECT match_no
	FROM match_details
	WHERE decided_by = 'P'
);
