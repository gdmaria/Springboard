"""Script to get weather reports from https://www.ncei.noaa.gov/.
"""
import json
import re
import concurrent.futures
import pandas as pd
from football_data_file import competition_code_get, current_season_get


def weather_report_list(competition_code, initial_load=False):
    """Return a list of all weather reports (station + year) covering competition matches.

    Parameters
    ----------
    competition_code : str
        Competition code.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, returns weather reports for all seasons vs. latest season only.

    Returns
    -------
        list.
    """
    # Get the mapping of team cities to weather stations.
    with open('city_weather_station_map.json', 'r') as f:
        city_station = json.load(f)

    available_years = []

    if initial_load:
        # Get the list of all available seasons for the competition.
        filename = competition_code + '_seasons.json'
        with open(filename, 'r') as f:
            competition_seasons = json.load(f)

        seasons = competition_seasons['seasons']
        # Only 3 latest seasons are available with a free license.
        available_years = [s['startDate'][:4] for s in seasons[:3]]

    current_season_end_year = current_season_get(competition_code)[1]
    if current_season_end_year not in available_years:
        available_years.append(current_season_end_year)

    reports = [(yr, st['station_usaf'] + st['station_wban']) for yr in available_years for st in city_station]

    return reports


def weather_report_url(competition_code, initial_load=False):
    """Return a list of URLs for all weather reports covering competition matches.

    Parameters
    ----------
    competition_code : str
        Competition code.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads weather reports for all seasons vs. latest season only.

    Returns
    -------
        list.
    """
    reports = weather_report_list(competition_code, initial_load)

    url = 'https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/'

    urls = [url + yr + '/' + st + '.csv' for yr, st in reports]

    return urls


def weather_report_file_download(url):
    """Download csv file from a URL.

    Parameters
    ----------
    url : str
        URL to a csv file.

    Returns
    -------
        if no exceptions: bool, str, str (True, weather report URL, number of records)
        if exception: bool, str, str (False, weather report URL, error)
    """
    try:
        df = pd.read_csv(url)
        re_f_name = re.compile('(.*/)(\d{4})/(\d+)\.csv')
        filename = re_f_name.search(url).group(3) + '_' + re_f_name.search(url).group(2) + '.csv'
        df.to_csv(filename)
        return True, url, str(len(df.index))
    except Exception as e:
        return False, url, str(e)


def weather_report_get(competition_name, initial_load=False):
    """Download weather report(s) in threads.

    Parameters
    ----------
    competition_name : str
        Competition name.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads weather reports for all seasons vs. latest season only.

    Returns
    -------
        list((bool, str, str)) (download status: True/False, weather report URL, number of records/error)
    """
    competition_code = competition_code_get(competition_name)

    if competition_code:
        csv_urls = weather_report_url(competition_code, initial_load)
        # with concurrent.futures.ThreadPoolExecutor() as executor:
        #     executor.map(weather_report_file_download, csv_urls)
        futures = []
        results = []
        with concurrent.futures.ThreadPoolExecutor() as executor:
            for csv_url in csv_urls:
                future = executor.submit(weather_report_file_download, csv_url)
                futures.append(future)

        for future in futures:
            results.append(future.result())
    else:
        raise Exception("Competition code for '{}' not found".format(competition_name))

    return results


if __name__ == '__main__':
    # print(weather_report_url('CL', True))
    weather_report_get('UEFA Champions League', True)
