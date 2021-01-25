-- Write a SQL query that returns the total number of goals scored by each position on
-- each country’s team. Do not include positions which scored no goals

SELECT pm.team_id, pm.posi_to_play, count(gd.goal_id) AS num_goals 
FROM goal_details AS gd
INNER JOIN player_mast AS pm ON gd.player_id = pm.player_id AND gd.team_id = pm.team_id
GROUP BY pm.team_id, pm.posi_to_play;
