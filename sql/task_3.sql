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
WHERE rnk < 11