-- Write a SQL query to find the highest number of foul cards given in one match

SELECT MAX(num_bookings) AS max_bookings
FROM
(
	SELECT match_no, COUNT(*) as num_bookings
	FROM player_booked
	GROUP BY match_no
) bookings;
