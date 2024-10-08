SELECT *
FROM
  (SELECT *,
          lag(stop_dttm) OVER (PARTITION BY UID ORDER BY start_dttm) AS prev_stop
   FROM wifi_session) AS t1
WHERE prev_stop > start_dttm