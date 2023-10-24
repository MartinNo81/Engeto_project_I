WITH t_year_0 AS (
	SELECT 
		`year` AS year_0,
		price AS price_0,
		name AS name_0 
	FROM t_martin_novak_project_SQL_primary_final t_0
	GROUP BY year_0, price_0, name_0 
),
t_year_1 AS (
	SELECT 
		`year`+ 1 AS year_1,
		price AS price_1,
		name AS name_1 
	FROM t_martin_novak_project_SQL_primary_final t_1
	GROUP BY year_1, price_1, name_1 
)
SELECT 
	name_1 AS product,
	round(avg(((price_0 - price_1)/price_1)*100),2) AS average_year_percentage_increase
FROM t_year_0 t_0
INNER JOIN t_year_1 t_1
	ON year_0 = year_1 AND name_0 = name_1	
GROUP BY name_1
ORDER BY average_year_percentage_increase DESC;