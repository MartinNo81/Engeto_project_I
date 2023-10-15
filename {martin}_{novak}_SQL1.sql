WITH t_year_0 AS (
	SELECT 
		`year` AS year0,
		avg(monthly_salary) AS salary0 ,
		industry AS industry0
	FROM t_martin_novak_project_SQL_primary_final t
	WHERE industry != '_All_in_one'
	GROUP BY `year` ,industry
),
t_year_1 AS (
	SELECT 
		`year`+ 1 AS year1,
		avg(monthly_salary) AS salary1 ,
		industry AS industry1
	FROM t_martin_novak_project_SQL_primary_final t1
	WHERE industry != '_All_in_one'
	GROUP BY `year` ,industry	
)
SELECT 
	year0,
	salary0,
	industry0,
	year1 -1,
	salary1,
	industry1,
	IF(salary0 > salary1,1,0) AS flag
FROM t_year_0 t
INNER JOIN t_year_1 t1
	ON year0 = year1 AND industry0 = industry1
ORDER BY flag ASC
LIMIT 25





