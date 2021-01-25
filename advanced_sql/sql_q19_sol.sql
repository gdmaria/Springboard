-- Write a SQL query to find the number of captains who were also goalkeepers.

SELECT COUNT(DISTINCT mc.player_captain) AS num_cap_gk
FROM match_captain AS mc
INNER JOIN player_mast AS pm ON mc.player_captain = pm.player_id 
WHERE pm.posi_to_play = 'GK';
