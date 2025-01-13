-- Identify Month with Highest Revenue For Each City

WITH CTE (city_name, `month`, revenue, rnk) AS (
	SELECT 
		dc.city_name,
        MONTHNAME(ft.date),
        SUM(ft.fare_amount),
        RANK() OVER(PARTITION BY dc.city_name ORDER BY SUM(ft.fare_amount) DESC)
	FROM trips_db.fact_trips ft INNER JOIN trips_db.dim_city dc
		USING(city_id)
	GROUP BY 1,2
),
CTE2 (city, total_revenue) AS (
	SELECT 
		dc.city_name,
        SUM(ft.fare_amount)
	FROM trips_db.fact_trips ft INNER JOIN trips_db.dim_city dc
		USING(city_id)
	GROUP BY 1
)

SELECT 
	city_name,
    `month`,
    revenue,
    CONCAT(ROUND(revenue*100/(SELECT total_revenue FROM CTE2 WHERE CTE.city_name = CTE2.city),2),'%') AS `percentage_contribution(%)`
    FROM CTE
    WHERE rnk = 1;
