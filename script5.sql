-- otázka 3


SELECT 
	av.food_category,
	av.payroll_year,
	round((av.average_food_value - av2.average_food_value) / av2.average_food_value * 100, 2) AS growth
FROM (
		SELECT
			food_category,
			payroll_year,
			round(avg(food_value), 2) AS average_food_value
		FROM t_lenka_loucka_project_sql_primary_final
		WHERE food_category IS NOT NULL 
		GROUP BY food_category, payroll_year) av
JOIN (
		SELECT
			food_category,
			payroll_year,
			round(avg(food_value), 2) AS average_food_value
		FROM t_lenka_loucka_project_sql_primary_final
		WHERE food_category IS NOT NULL 
		GROUP BY food_category, payroll_year) av2
	ON av.food_category = av2.food_category
	AND av.payroll_year = av2.payroll_year + 1
HAVING growth > 0
ORDER BY growth;

