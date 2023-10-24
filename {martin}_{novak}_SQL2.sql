SELECT 	
	`year`,
	name,
	round((monthly_salary / price ), 2) AS food_index,
	price,
	`_value`,
	price_unit,
	IF(name LIKE 'Mléko%' OR name LIKE 'Chléb%',1,0) AS flag
FROM t_martin_novak_project_sql_primary_final tmnpspf 
WHERE 
	`year`= 2018 AND industry = '_All_industry'
	OR `year`= 2006 AND industry = '_All_industry'
HAVING flag=1;