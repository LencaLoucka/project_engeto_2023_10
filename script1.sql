

CREATE TABLE IF NOT EXISTS t_lenka_loucka_project_SQL_primary_final AS
SELECT 
	cp.payroll_year,
	cp.value AS avg_value,
	cpib.code AS industry_branch_code,
	cpib.name AS industry_name,
	cp2.category_code AS food_category,
	cpc.name AS food_name,
	cp2.value AS food_value,
	cpc.price_value,
	cpc.price_unit 	
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2 
	ON year(cp2.date_from) = cp.payroll_year 
	AND cp2.region_code IS NULL 
LEFT JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cpib.code = cp.industry_branch_code 
WHERE cp.value_type_code = 5958
	AND cp.payroll_year BETWEEN 2006 AND 2018;


