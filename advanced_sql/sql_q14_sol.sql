-- Write a SQL query to find referees and the number of bookings they made for the
-- entire tournament. Sort your answer by the number of bookings in descending order

SELECT rm.referee_id, rm.referee_name, ref.num_bookings
FROM referee_mast AS rm
LEFT JOIN 
(
	SELECT mm.referee_id, COUNT(*) AS num_bookings
    FROM match_mast AS mm
    INNER JOIN player_booked AS pb ON mm.match_no = pb.match_no
    GROUP BY mm.referee_id
) AS ref
ON rm.referee_id = ref.referee_id
ORDER BY num_bookings DESC, rm.referee_name;
