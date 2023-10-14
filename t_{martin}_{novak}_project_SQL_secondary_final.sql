CREATE OR REPLACE TABLE t_martin_novak_project_SQL_secondary_final AS
SELECT
	c.country ,
	c.capital_city ,
	e.population ,
	e.`year` ,
	e.GDP 
FROM countries c
LEFT JOIN economies e 
	ON lower(c.country) = lower(e.country)  
WHERE 
	lower(c.continent) = 'europe' 
	AND e.`year` >= 2006
	AND e.`year` <= 2018
	AND lower(c.country) NOT LIKE 'czech%' ;