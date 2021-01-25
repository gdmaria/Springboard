-- Write a SQL query to find the number of matches that were won by penalty shootout.

SELECT COUNT(DISTINCT match_no) AS num_won_by_penalty_shootout
FROM match_details
WHERE decided_by = 'P';
