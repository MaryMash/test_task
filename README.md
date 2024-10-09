# Тестовое задание

1. [SQL](https://github.com/MaryMash/test_task/blob/main/sql/task.sql)
2. [Python](https://github.com/MaryMash/test_task/blob/main/python/task.py)
   - отчеты загружаются в папку [reports](https://github.com/MaryMash/test_task/blob/main/python/reports)
   - команды для запуска скрипта:
        ```bash
        pip install -r requirements.txt
        cd python
        echo -e "API_KEY"={ключ к API Яндекс Расписаний} > .env
        chmod ugo+x task.py
        python ./task.py
        ```