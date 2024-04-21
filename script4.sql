-- otázka 2

		
SELECT 
	av.*,
	av2.*,
	round( average_values / average_food_values)
FROM (
		SELECT
			payroll_year,
			round(avg(avg_value), 2) AS average_values
		FROM t_lenka_loucka_project_sql_primary_final
		WHERE payroll_year IN (
				SELECT 
					min(payroll_year) 
				FROM t_lenka_loucka_project_sql_primary_final tll
				WHERE food_category IS NOT NULL)
			OR payroll_year IN (
				SELECT 
					max(payroll_year)
				FROM t_lenka_loucka_project_sql_primary_final tll
				WHERE food_category IS NOT NULL)
		GROUP BY payroll_year)av
LEFT JOIN (
		SELECT 
			payroll_year,
			food_name, 
			round(avg(food_value), 2) AS average_food_values
		FROM t_lenka_loucka_project_sql_primary_final tll
		WHERE food_category = 114201
			OR food_category = 111301
		GROUP BY food_name,payroll_year)av2
ON av.payroll_year = av2.payroll_year;

