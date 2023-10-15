WITH t_year_0 AS (
		SELECT
			monthly_salary AS monthly_salary0,
			industry AS industry0,
			`year` AS year0,
			avg(price) AS price0,
			gdp AS gdp0			
		FROM t_martin_novak_project_SQL_primary_final t0
		WHERE industry = '_All_in_one'
		GROUP BY monthly_salary0 , industry0 ,year0,gdp0 
),
t_year_1 AS (
		SELECT
			monthly_salary AS monthly_salary1,
			industry AS industry1,
			`year`+1 AS year1,
			avg(price) AS price1,
			gdp AS gdp1
		FROM t_martin_novak_project_SQL_primary_final t1
		WHERE industry = '_All_in_one'
		GROUP BY monthly_salary1 , industry1 ,year1,gdp1 
)
SELECT
	concat(year1-1,'-->',year0) AS period,
	(((gdp0 - gdp1)/gdp1)*100)AS year_increase_GDP,
	round((((price0 - price1)/price1)*100),2) AS year_increase_price_pct,
	round((((monthly_salary0 - monthly_salary1)/monthly_salary1)*100),2) AS year_increase_salary_pct
FROM t_year_0 t0
INNER JOIN t_year_1 t1
	ON year0 = year1
ORDER BY period ;