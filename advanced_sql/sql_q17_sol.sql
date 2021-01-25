-- Write a SQL query to find the country where the most assistant referees come from,
-- and the count of the assistant referees

WITH ref AS
(
	SELECT country_id, COUNT(ass_ref_id) AS num_assistant_ref_per_country
	FROM asst_referee_mast
    GROUP BY country_id
),
country_rnk AS
(
	SELECT country_id, num_assistant_ref_per_country,
		RANK() OVER(ORDER BY num_assistant_ref_per_country DESC) AS rnk, 
        SUM(num_assistant_ref_per_country) OVER() as num_assistant_ref_total
    FROM ref
)
SELECT country_name, num_assistant_ref_per_country, num_assistant_ref_total
FROM country_rnk 
INNER JOIN soccer_country ON country_rnk.country_id = soccer_country.country_id
WHERE rnk = 1;
