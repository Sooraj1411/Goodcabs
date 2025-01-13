-- City-Level Fare and Trip Summary Report

SELECT
	dc.city_name,
    COUNT(ft.trip_id) AS `total_trips`,
    CONCAT(ROUND(SUM(ft.fare_amount)/SUM(ft.distance_travelled_km),1), 'Rs') AS `avg_fare_per_km`,
    CONCAT(ROUND(SUM(ft.fare_amount)/COUNT(ft.trip_id),1), 'Rs') AS `avg_fare_per_trip`,
    CONCAT(ROUND(COUNT(ft.city_id)*100/(SELECT COUNT(*) FROM trips_db.fact_trips),2),'%') AS `%_contribution_to_total_trips`
FROM trips_db.dim_city dc INNER JOIN trips_db.fact_trips ft
	USING(city_id)
GROUP BY dc.city_name;
