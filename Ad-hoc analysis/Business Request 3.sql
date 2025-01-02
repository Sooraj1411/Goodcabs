-- Business Request 3 - City-Level Repeat Passenger Trips Frequency Report

SELECT
	dc.city_name,
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '2-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '2-Trips',
	CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '3-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '3-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '4-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '4-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '5-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '5-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '6-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '6-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '7-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '7-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '8-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '8-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '9-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '9-Trips',
    CONCAT(ROUND(SUM(CASE WHEN td.trip_count = '10-Trips' THEN td.repeat_passenger_count ELSE 0 END)*100/SUM(td.repeat_passenger_count),1),'%')
    AS '10-Trips'
FROM trips_db.dim_repeat_trip_distribution td INNER JOIN trips_db.dim_city dc
	USING(city_id)
GROUP BY 1;
