-- otázka 5

SELECT 
	av.*,
	round((av.GDP - av2.GDP) / av2.GDP * 100, 2) AS percent_GDP
FROM (
	SELECT 
		payroll_year,
		GDP,
		round(avg(avg_value), 2) AS 'avg_value2',
		round (avg(food_value), 2) AS 'food_value2'
	FROM t_lenka_loucka_project_sql_secondary_final
	GROUP BY payroll_year, GDP) av
JOIN (
	SELECT 
		payroll_year,
		GDP,
		round(avg(avg_value), 2) AS 'avg_value2',
		round (avg(food_value), 2) AS 'food_value2'
	FROM t_lenka_loucka_project_sql_secondary_final
	GROUP BY payroll_year,GDP) av2
ON av.payroll_year = av2.payroll_year + 1
GROUP BY payroll_year
HAVING food_value2 IS NOT NULL;

