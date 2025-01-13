-- Repeat Passenger Rate Analysis
WITH CTE (city, city_repeat_passenger_rate) AS (
	SELECT 
		city_name,
		CONCAT(ROUND(SUM(fps.repeat_passengers)*100/SUM(fps.total_passengers),2),'%')
	FROM trips_db.fact_passenger_summary fps INNER JOIN trips_db.dim_city dc
		USING(city_id)
	GROUP BY 1
)
SELECT
	dc.city_name,
    MONTHNAME(fps.month) AS `month`,
    fps.total_passengers,
    fps.repeat_passengers,
    CONCAT(ROUND(fps.repeat_passengers*100/fps.total_passengers,2),'%') AS `monthly_repeat_passenger_rate(%)`,
    (SELECT city_repeat_passenger_rate FROM CTE WHERE CTE.city = dc.city_name) AS `city_repeat_passenger_rate`
FROM trips_db.fact_passenger_summary fps INNER JOIN trips_db.dim_city dc
	USING(city_id);
