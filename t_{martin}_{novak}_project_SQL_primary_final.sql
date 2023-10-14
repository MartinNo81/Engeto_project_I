CREATE OR REPLACE TABLE t_martin_novak_project_SQL_primary_final AS
WITH payroll_table AS (
	SELECT
		round(avg(cp.value),2) AS monthly_salary,
		IF(cpib.name  IS NULL,'_All_in_one',cpib.name ) AS industry,
		cp.payroll_year
	FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code 
	WHERE 
		cp.calculation_code = 200
		AND cp.unit_code = 200
		AND cp.value_type_code  = 5958
		AND cp.payroll_year >= 2006
		AND cp.payroll_year <= 2018 
	GROUP BY industry, cp.payroll_year
),
price_table AS (
	SELECT
		round(avg (cp.value),2) AS price ,
		cpc.name AS name,
		cpc.price_value AS _value ,
		cpc.price_unit AS price_unit ,
		year(cp.date_from) AS price_year
	FROM czechia_price cp
	LEFT JOIN czechia_price_category cpc 
		ON cp.category_code = cpc.code 
	WHERE cp.region_code  IS NULL 
	GROUP BY name, _value, price_unit, year(cp.date_from)
),
czech_gdp_table AS (
	SELECT
		round(e.GDP,0)  AS gdp,
		e.`year` AS `year`
	FROM economies e
	WHERE 
		`year` >= 2006
		AND `year` <= 2018
		AND lower(country) LIKE 'czech%'
)
SELECT 
	`year`,	
	monthly_salary,
	industry,
	price,
	name,
	_value,
	price_unit,
	gdp
FROM payroll_table prt 
LEFT JOIN price_table pct 
	ON prt.payroll_year = pct.price_year
LEFT JOIN czech_gdp_table czegdp
	ON prt.payroll_year = czegdp.`year` ;


