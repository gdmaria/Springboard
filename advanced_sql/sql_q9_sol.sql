-- Write a SQL query to find the goalkeeper’s name and jersey number, playing for
-- Germany, who played in Germany’s group stage matches

SELECT player_name, jersey_no
FROM player_mast
WHERE posi_to_play = 'GK'
	AND team_id IN
    (	
		SELECT md.team_id
		FROM match_details AS md
		INNER JOIN soccer_country AS sc ON md.team_id = sc.country_id
		WHERE sc.country_name = 'Germany' AND md.play_stage = 'G'
	);

