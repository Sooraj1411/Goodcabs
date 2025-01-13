-- Identify Cities with Highest & Lowest Total New Passengers

(SELECT 
	dc.city_name, 
    SUM(fps.new_passengers) AS total_new_passengers,
    "Top 3" AS city_category
FROM trips_db.fact_passenger_summary fps INNER JOIN trips_db.dim_city dc
	USING(city_id)
GROUP BY dc.city_name
ORDER BY total_new_passengers DESC
LIMIT 3
)
UNION
(SELECT 
	dc.city_name, 
    SUM(fps.new_passengers) AS total_new_passengers,
    "Bottom 3"
FROM trips_db.fact_passenger_summary fps INNER JOIN trips_db.dim_city dc
	USING(city_id)
GROUP BY dc.city_name
ORDER BY total_new_passengers ASC
LIMIT 3);
	
-- OR
    
WITH CTE AS (SELECT 
	dc.city_name,
    COUNT(IF(ft.passenger_type = 'new',1,NULL)) AS total_new_passengers,
    RANK() OVER(ORDER BY COUNT(IF(ft.passenger_type = 'new',1,NULL))) AS rnk
FROM trips_db.fact_trips ft INNER JOIN trips_db.dim_city dc
	USING(city_id)
GROUP BY 1)

SELECT 
	city_name,
	total_new_passengers,
    CASE
		WHEN rnk >= 8 THEN 'Top 3'
		WHEN rnk <= 3 THEN 'Bottom 3'
	END AS city_category
FROM CTE
WHERE rnk <= 3 OR rnk >= 8
ORDER BY city_category DESC;
