WITH t_year_0 AS (
		SELECT
			monthly_salary AS monthly_salary_0,
			industry AS industry_0,
			`year` AS year_0,
			avg(price) AS price_0
		FROM t_martin_novak_project_SQL_primary_final t_0
		WHERE industry = '_All_industry'
		GROUP BY monthly_salary_0 , industry_0 ,year_0 
),
t_year_1 AS (
		SELECT
			monthly_salary AS monthly_salary_1,
			industry AS industry_1,
			`year`+1 AS year_1,
			avg(price) AS price_1
		FROM t_martin_novak_project_SQL_primary_final t_1
		WHERE industry = '_All_industry'
		GROUP BY monthly_salary_1, industry_1, year_1 
)
SELECT
	concat(year_1-1,'-->',year_0) AS period,
	round((((price_0 - price_1)/price_1)*100),2) AS year_increase_price_pct,
	round((((monthly_salary_0 - monthly_salary_1)/monthly_salary_1)*100),2) AS year_increase_salary_pct,
	round((((price_0 - price_1)/price_1)*100) - (((monthly_salary_0 - monthly_salary_1)/monthly_salary_1)*100),2) AS difference 
FROM t_year_0 t0
INNER JOIN t_year_1 t1
	ON year_0 = year_1
ORDER BY period;