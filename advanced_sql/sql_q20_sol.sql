-- Write a SQL query to find the substitute players who came into the field in the first
-- half of play, within a normal play schedule

SELECT pio.player_id, pm.player_name
FROM player_in_out AS pio
INNER JOIN player_mast AS pm ON pio.player_id = pm.player_id
WHERE in_out = 'I' AND play_half = '1' AND play_schedule = 'NT';
