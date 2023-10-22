CREATE OR REPLACE TABLE t_martin_novak_project_SQL_secondary_final AS
SELECT
	c.country,
	e.population,
	e.gini,
	round(e.GDP,0) AS GDP,
	e.`year` 
FROM countries c
LEFT JOIN economies e 
	ON lower(c.country) = lower(e.country)  
WHERE 
	lower(c.continent) = 'europe' 
	AND e.`year` BETWEEN 2006 AND 2018
	AND lower(c.country) NOT LIKE 'czech%';