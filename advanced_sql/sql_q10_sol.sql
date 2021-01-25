-- Write a SQL query to find all available information about the players under contract to
-- Liverpool F.C. playing for England in EURO Cup 2016.

SELECT *
FROM player_mast
WHERE team_id IN
    (	
		SELECT md.team_id
		FROM match_details AS md
		INNER JOIN soccer_country AS sc ON md.team_id = sc.country_id
		WHERE sc.country_name = 'England'
	)
	AND playing_club = 'Liverpool';
