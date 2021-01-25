-- Write a SQL query to find the number of bookings that happened in stoppage time

SELECT COUNT(*) AS num_bookings_stoppage_time
FROM player_booked
WHERE play_schedule = 'ST';
