WITH t_year_0 AS (
	SELECT 
		`year` AS year0,
		avg(price) AS price0,
		name AS name0 
	FROM t_martin_novak_project_SQL_primary_final t0
	GROUP BY `year`, name
),
t_year_1 AS (
	SELECT 
		`year`+ 1 AS year1,
		avg(price) AS price1,
		name AS name1 
	FROM t_martin_novak_project_SQL_primary_final t1
	GROUP BY `year`, name
)
SELECT 
	name1 AS product,
	round(avg(((price0 - price1)/price1)*100),2) AS average_year_percentage_increase
FROM t_year_0 t0
INNER JOIN t_year_1 t1
	ON year0 = year1 AND name0 = name1	
GROUP BY name1
ORDER BY average_year_percentage_increase DESC ; 


	

	
