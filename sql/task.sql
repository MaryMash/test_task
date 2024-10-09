-- task 1
SELECT DISTINCT UID
FROM wifi_session
WHERE (start_station IN (50, 161)
       AND start_dttm > CURRENT_DATE - interval '3 MONTH')
  OR (stop_station IN (50, 161)
      AND stop_dttm > CURRENT_DATE - interval '3 MONTH')
GROUP BY UID
HAVING count(*) > 50;


-- task 2
SELECT *
FROM
  (SELECT *,
          lag(stop_dttm) OVER (PARTITION BY UID ORDER BY start_dttm) AS prev_stop
   FROM wifi_session) AS t1
WHERE prev_stop > start_dttm;

-- task 3
WITH station_data AS
  (SELECT station,
          count(*) AS cnt
   FROM
     (SELECT start_station AS station
      FROM wifi_session
      UNION ALL SELECT stop_station
      FROM wifi_session) AS t1
   GROUP BY station)
SELECT station,
       rnk
FROM
  (SELECT station,
          cnt,
          DENSE_RANK() OVER (
                             ORDER BY cnt DESC) AS rnk
   FROM station_data) AS t2
WHERE rnk < 11;

-- task 4
WITH stop_stations AS
  (SELECT UID,
          stop_station,
          count(*) AS cnt
   FROM wifi_session
   GROUP BY UID,
            stop_station)
SELECT stop_station
FROM
  (SELECT *,
          DENSE_RANK() OVER (PARTITION BY UID ORDER BY cnt DESC) AS rnk
   FROM stop_stations) AS t1
WHERE rnk = 1;