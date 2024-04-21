-- otázka 4

SELECT 
	*,
	round((av.average_food_value - av2.average_food_value) / av2.average_food_value * 100, 2) AS 'growth',
	CASE 
		WHEN round((av.average_food_value - av2.average_food_value) / av2.average_food_value * 100, 2) > 10 THEN 1
		ELSE 0
	END AS percent_growth	
FROM (
		SELECT 
			payroll_year,
			round(avg(food_value), 2) AS average_food_value
		FROM t_lenka_loucka_project_sql_primary_final 
		WHERE food_value IS NOT NULL 
		GROUP BY payroll_year) av
JOIN (
		SELECT 
			payroll_year,
			round(avg(food_value), 2) AS average_food_value
		FROM t_lenka_loucka_project_sql_primary_final 
		WHERE food_value IS NOT NULL 
		GROUP BY payroll_year) av2
ON av.payroll_year = av2.payroll_year + 1	
