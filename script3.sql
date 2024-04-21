-- otázka 1

SELECT 
	av.industry_branch_code,
	av.industry_name,
	av.payroll_year,
	round((av.average_values - av2.average_values) / av2.average_values * 100, 2) AS growth,
	CASE
		WHEN round((av.average_values - av2.average_values) / av2.average_values * 100, 2) < 0 THEN 'mzda klesá'
		WHEN round((av.average_values - av2.average_values) / av2.average_values * 100, 2) > 0 THEN 'mzda stoupá'
		ELSE 'nemění se'
	END AS 'result'
FROM (
		SELECT
			industry_branch_code,
			industry_name,
			payroll_year,
			round(avg(avg_value), 2) AS average_values
		FROM t_lenka_loucka_project_sql_primary_final
		WHERE industry_branch_code IS NOT NULL
		GROUP BY industry_branch_code,industry_name,payroll_year) av 
JOIN (
		SELECT
			industry_branch_code,
			payroll_year,
			round(avg(avg_value), 2) AS average_values
		FROM t_lenka_loucka_project_sql_primary_final		
		WHERE industry_branch_code IS NOT NULL
		GROUP BY industry_branch_code,industry_name,payroll_year) av2 
	ON av.industry_branch_code = av2.industry_branch_code
	AND av.payroll_year = av2.payroll_year + 1;


