WITH t_year_0 AS (
	SELECT 
		`year` AS year_0,
		monthly_salary AS salary_0,
		industry AS industry_0
	FROM t_martin_novak_project_SQL_primary_final t_0
	WHERE industry != '_All_industry'
	GROUP BY year_0, salary_0, industry_0
),
t_year_1 AS (
	SELECT 
		`year`+ 1 AS year_1,
		monthly_salary AS salary_1 ,
		industry AS industry_1
	FROM t_martin_novak_project_SQL_primary_final t_1
	WHERE industry != '_All_industry'
	GROUP BY year_1, salary_1, industry_1	
)
SELECT 
	year_0,
	salary_0,
	industry_0,
	year_1 -1,
	salary_1,
	industry_1,
	CASE 
		WHEN salary_1 - salary_0 BETWEEN 0 AND 100 THEN 'less then 0100'
		WHEN salary_1 - salary_0 BETWEEN 101 AND 500 THEN 'less then 0500'
		WHEN salary_1 - salary_0 BETWEEN 501 AND 1000 THEN 'less then 1000'
		WHEN salary_1 - salary_0 > 1000 THEN 'more then 1000'
		ELSE NULL 
	END AS decrease_salary
FROM t_year_0 t
INNER JOIN t_year_1 t1
	ON year_0 = year_1 AND industry_0 = industry_1
ORDER BY decrease_salary DESC
LIMIT 25;



