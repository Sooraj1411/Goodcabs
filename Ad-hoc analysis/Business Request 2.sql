-- Business Request 2 - Monthly City Level-Trips Target Performance Report

WITH target (city_name,`month`,`target_trips`) AS (
	SELECT 
		dc.city_name,
		MONTHNAME(mtt.month) AS `month`,
		mtt.total_target_trips AS `target_trips`
	FROM trips_db.dim_city dc INNER JOIN targets_db.monthly_target_trips mtt
		USING(city_id)
),
reality (city_name,`month`,`actual_trips`) AS (
	SELECT
		dc.city_name,
		MONTHNAME(ft.date),
		COUNT(ft.trip_id)
	FROM trips_db.dim_city dc INNER JOIN trips_db.fact_trips ft
		USING(city_id)
	GROUP BY 1,2
)

SELECT
    tr.city_name,
    tr.`month`,
    re.actual_trips,
    tr.target_trips,
    CASE
		WHEN (re.actual_trips - tr.target_trips >= 0) THEN "Above Target"
        ELSE "Below Target"
	END AS `performance_status`,
    ROUND((re.actual_trips - tr.target_trips)*100/tr.target_trips,1) AS `%_difference`
FROM target tr INNER JOIN reality re
ON tr.city_name = re.city_name AND tr.`month` = re.`month`;
