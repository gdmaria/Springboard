-- Write a SQL query to compute a list showing the number of substitutions that
-- happened in various stages of play for the entire tournament.

SELECT mm.play_stage, COUNT(DISTINCT pio.team_id, pio.time_in_out) AS num_subs_per_stage
FROM match_mast AS mm
LEFT JOIN player_in_out AS pio ON mm.match_no = pio.match_no
GROUP BY mm.play_stage;
