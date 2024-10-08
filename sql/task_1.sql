SELECT DISTINCT UID
FROM wifi_session
WHERE (start_station IN (50, 161)
       AND start_dttm > CURRENT_DATE - interval '3 MONTH')
  OR (stop_station IN (50, 161)
      AND stop_dttm > CURRENT_DATE - interval '3 MONTH')
GROUP BY UID
HAVING count(*) > 50