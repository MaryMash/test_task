import os

from dotenv import load_dotenv

from api_lib.YandexAPI import YandexAPI


load_dotenv(os.getcwd() + '/.env')

KEY = os.getenv('API_KEY')
URL = 'https://api.rasp.yandex.net/v3.0/stations_list/'

api = YandexAPI(KEY, URL)
api.get_report()
