CREATE TABLE IF NOT EXISTS t_lenka_loucka_project_SQL_secondary_final AS
SELECT 
	cp.payroll_year,
	cp.value AS avg_value,
	cp2.value AS food_value,
	gd.GDP
	FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2 
	ON year(cp2.date_from) = cp.payroll_year 
	AND cp2.region_code IS NULL
	LEFT JOIN (
		SELECT 
			country,
			YEAR AS 'year_GDP',
			GDP
		FROM economies e 
		WHERE country = 'Czech Republic')gd
	ON 	gd.year_GDP = cp.payroll_year 
WHERE value_type_code = 5958
AND cp.payroll_year BETWEEN 2006 AND 2018;

