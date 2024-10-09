from datetime import date
from pathlib import Path

import numpy as np
import pandas as pd
import requests


class YandexAPI:
    def __init__(self, api_key, url):
        self.__headers = {'Authorization': api_key}
        self.endpoint = url

    def get_data(self):
        response = requests.get(self.endpoint, headers=self.__headers).json()
        return response

    @staticmethod
    def format_data(data):
        result = []
        for country in data['countries']:
            for region in country['regions']:
                for settlement in region['settlements']:
                    for station in settlement['stations']:
                        result.append([country['title'],
                                       settlement['title'],
                                       station['title'],
                                       station['direction'],
                                       station['codes']['yandex_code'],
                                       station['station_type'],
                                       station['transport_type'],
                                       station['longitude'],
                                       station['latitude']
                                       ])
        df = pd.DataFrame(np.array(result), columns=['country_nm',
                                                     'settlement_nm',
                                                     'station_nm',
                                                     'direction',
                                                     'yandex_cd',
                                                     'station_type',
                                                     'transport_type',
                                                     'long',
                                                     'lat'])

        return df

    def get_report(self):
        report_data = self.get_data()
        report = self.format_data(report_data)
        dt = date.today().strftime('%Y-%m-%d')
        filepath = Path(f'./reports/report_{dt}.csv')
        filepath.parent.mkdir(parents=True, exist_ok=True)
        report.to_csv(filepath, index=False)
