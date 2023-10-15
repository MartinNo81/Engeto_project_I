SELECT 	
	`year`,
	name ,
	round((monthly_salary / price ), 2) AS food_index,
	price ,
	`_value` ,
	price_unit ,
	IF(name LIKE 'Mléko%',1,0) AS flag_milk,
	IF(name LIKE 'Chléb%',1,0) AS flag_bread
FROM t_martin_novak_project_sql_primary_final tmnpspf 
WHERE 
	`year`= 2018 AND industry = '_All_in_one'
	OR `year`= 2006 AND industry = '_All_in_one'
HAVING flag_milk = 1 OR flag_bread = 1