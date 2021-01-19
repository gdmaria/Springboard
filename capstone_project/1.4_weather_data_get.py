"""Script to get weather reports from https://www.ncei.noaa.gov/.
"""
import json
import pandas as pd
import re
import concurrent.futures
from football_data_file_read import competition_code


def weather_report_url(competition_code):
    """
    Return a list of URLs for all weather reports covering competition matches.

    Parameters
    ----------
    competition_code : str
        Competition code.

    Returns
    -------
        list.
    """
    # Get the mapping of team cities to weather stations.
    with open('city_weather_station_map.json', 'r') as f:
        city_station = json.load(f)

    # Get the list of all available seasons for the competition.
    filename = competition_code + '_seasons.json'
    with open(filename, 'r') as f:
        competition_seasons = json.load(f)

    seasons = competition_seasons['seasons']

    url = 'https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/'
    # Only 3 latest seasons are available with a free license.
    urls = [url + s['startDate'][:4] + '/' + st['station_usaf'] + st['station_wban'] + '.csv'
            for s in seasons[:3] for st in city_station]

    return urls


def weather_report_file_download(url):
    """
    Download csv file from a URL.

    Parameters
    ----------
    url : str
        URL to a csv file.
    """
    try:
        df = pd.read_csv(url)
        re_f_name = re.compile('(.*/)(\d{4})/(\d+)\.csv')
        filename = re_f_name.search(url).group(3) + '_' + re_f_name.search(url).group(2) + '.csv'
        df.to_csv(filename)
    except Exception as e:
        print(e, url)


if __name__ == '__main__':
    cl_code = competition_code('UEFA Champions League')
    csv_urls = weather_report_url(cl_code)
    with concurrent.futures.ThreadPoolExecutor() as executor:
        executor.map(weather_report_file_download, csv_urls)
