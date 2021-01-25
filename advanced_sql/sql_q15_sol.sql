-- Write a SQL query to find the referees who booked the most number of players

WITH ref AS (
	SELECT mm.referee_id, COUNT(DISTINCT pb.player_id) AS num_players_booked, RANK() OVER(ORDER BY COUNT(DISTINCT pb.player_id) DESC) as rnk
	FROM match_mast AS mm
	INNER JOIN player_booked AS pb ON mm.match_no = pb.match_no
	GROUP BY mm.referee_id
)
SELECT rm.referee_id, rm.referee_name, ref.num_players_booked
FROM ref
INNER JOIN referee_mast AS rm ON ref.referee_id = rm.referee_id
WHERE ref.rnk = 1;
