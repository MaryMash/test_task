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
WHERE rnk = 1