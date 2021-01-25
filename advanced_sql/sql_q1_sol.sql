-- Write a SQL query to find the date EURO Cup 2016 started on

SELECT MIN(play_date) AS cup_start_date
FROM match_mast;
