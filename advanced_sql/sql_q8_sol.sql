-- Write a SQL query to find the match number for the game with the highest number of
-- penalty shots, and which countries played that match

SET @max_penalty_score = (SELECT MAX(penalty_score) FROM match_details);

SELECT md.match_no, sc.country_name
FROM match_details AS md
INNER JOIN soccer_country AS sc ON md.team_id = sc.country_id
WHERE md.match_no IN (SELECT match_no FROM match_details WHERE penalty_score = @max_penalty_score);
