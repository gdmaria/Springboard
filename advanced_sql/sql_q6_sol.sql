-- Write a SQL query to find the number of matches that were won by a single point, but
-- do not include matches decided by penalty shootout.

SELECT match_no	
FROM match_mast
WHERE results = 'WIN'
	AND ABS(SUBSTRING_INDEX(goal_score, '-', 1) - SUBSTRING_INDEX(goal_score, '-', -1)) = 1;
