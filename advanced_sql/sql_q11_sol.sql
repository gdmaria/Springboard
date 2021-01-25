-- Write a SQL query to find the players, their jersey number, and playing club who
-- were the goalkeepers for England in EURO Cup 2016.

SELECT player_name, jersey_no, playing_club
FROM player_mast
WHERE posi_to_play = 'GK'
	AND team_id IN
    (	
		SELECT md.team_id
		FROM match_details AS md
		INNER JOIN soccer_country AS sc ON md.team_id = sc.country_id
		WHERE sc.country_name = 'England'
	);
