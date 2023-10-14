CREATE OR REPLACE VIEW v_payroll_table AS 
SELECT
	cp.value,
	cpu.name AS 'unit_of_value',
	cpvt.code AS 'code_of_value',
	cpvt.name AS 'name_of_value',
	cp.industry_branch_code,
	cpib.name AS 'name_of_industry',
	cp.payroll_year,
	cp.payroll_quarter,
	CASE
		WHEN cp.payroll_year < 2006 THEN 0
		WHEN cp.payroll_year > 2018 THEN 0
		WHEN cp.payroll_year = 2018 AND cp.payroll_quarter = 4 THEN 0
		ELSE 1
	END AS flag
FROM czechia_payroll cp
LEFT JOIN czechia_payroll_value_type cpvt 
	ON cp.value_type_code = cpvt.code 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code 
LEFT JOIN czechia_payroll_unit cpu 
	ON cp.unit_code = cpu.code 
WHERE 
	cp.calculation_code = 200
	AND cp.value_type_code  = 5958
GROUP BY
	cp.payroll_year ,cp.payroll_quarter ,cp.industry_branch_code ;

CREATE OR REPLACE VIEW v_price_table AS 
SELECT
	round(avg (value),2) AS 'price' ,
	cpc.code AS 'code',
	cpc.name AS 'name' ,
	cpc.price_value AS 'value' ,
	cpc.price_unit AS 'price_unit' ,
	year(cp.date_from)	AS '_year',
	quarter(date(cp.date_from)) AS '_quarter'
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
WHERE cp.region_code  IS NULL 
GROUP BY cpc.name, year(cp.date_from), quarter(date(cp.date_from));


CREATE  OR REPLACE VIEW v_Czech_GDP_table AS
SELECT
	c.country ,
	c.capital_city ,
	c.continent ,
	e.`year` ,
	e.GDP 
FROM countries c
LEFT JOIN economies e 
	ON lower(c.country) = lower(e.country)  
WHERE 
	lower(c.continent) = 'europe' 
	AND e.`year` >= 2006
	AND e.`year` <= 2018
	AND lower(c.country) LIKE 'czech%';
	
SELECT 
	vpt.value ,
	vpt.unit_of_value ,
	vpt.code_of_value  ,
	vpt.industry_branch_code ,
	vpt.name_of_industry ,
	vpt2.price ,
	vpt2.code  ,
	vpt2.value ,
	vpt2.price_unit ,
	vpt2._year ,
	vpt2._quarter,
	gdp.GDP 
FROM v_payroll_table vpt 
LEFT JOIN v_price_table vpt2 
	ON vpt.payroll_year = vpt2._year AND vpt.payroll_quarter = vpt2._quarter 
LEFT JOIN v_czech_gdp_table gdp
	ON vpt.payroll_year = gdp.`year` 
WHERE vpt2.price IS NOT NULL;