-- discrepancy for match_no = 50
/*
SELECT 
	match_mast.*, 
	REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(goal_score, 'Jan', '1'), 'Feb', '2'), 'Mar', '3'), 'May', '5'), '00', '0') AS goal_score_upd,
	scores.score
FROM match_mast
LEFT JOIN (
	SELECT match_no, GROUP_CONCAT(goal_score SEPARATOR '-') AS score
	FROM match_details
	GROUP BY match_no
) scores ON match_mast.match_no = scores.match_no
*/

UPDATE match_mast
SET goal_score = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(goal_score, 'Jan', '1'), 'Feb', '2'), 'Mar', '3'), 'May', '5'), '00', '0')
