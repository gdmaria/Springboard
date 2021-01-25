-- Write a SQL query to find all the defenders who scored a goal for their teams

SELECT pm.*
FROM player_mast AS pm 
WHERE pm.posi_to_play = 'DF'
	AND EXISTS (
		SELECT gd.goal_id
		FROM goal_details AS gd 
		WHERE gd.player_id = pm.player_id AND gd.team_id = pm.team_id    
    );

