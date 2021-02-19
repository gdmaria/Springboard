"""Module containing functions for getting football data from the https://www.football-data.org/ API.
"""
import json
import time
import http.client
from football_data_file import all_seasons_get


class FootballApiException(Exception):
    pass


def api_call(uri):
    """Get specified resource from the API.

    Parameters
    ----------
    uri : str
        Resource URI.

    Returns
    -------
        json object
    """
    connection = http.client.HTTPConnection('api.football-data.org')
    headers = {'X-Auth-Token': '8aed48af305e4e8f86bc513632c675e3'}
    connection.request('GET', uri, None, headers)
    response = json.loads(connection.getresponse().read().decode())
    if 'error' in response:
        raise FootballApiException('HTTP error code {}'.format(response['error']))

    return response


def api_resource_get(resource, competition_code, season_year):
    """Write API response for specified resource to json file.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').

    competition_code : str
        Competition code.

    season_year : str
        Season year in yyyy format.

    Returns
    -------
        str, int (file name, number of records)
    """
    uri = '/v2/competitions/' + competition_code + '/' + resource + '?season=' + season_year
    try:
        response = api_call(uri)
        filename = competition_code + '_' + resource + '_' + season_year + '.json'
        with open(filename, 'w') as f:
            json.dump(response, f, indent=2)

        return True, uri, len(response[resource])
    except Exception as e:
        return False, uri, str(e)


def api_resources_get(resource, competition_code, res_list, initial_load=False):
    """Write team/match data of a competition to json files (one file per season).

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').

    competition_code : str
        Competition code.

    res_list : list
        List of tuples with the results of failed downloads from a previous attempt.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads team/match data for all seasons vs. latest season only.

    Returns
    -------
        int, list((str, int)) (number of created json files, list((file name, number of season records)))
    """
    # Get a list of all available seasons for the competition.
    available_years = all_seasons_get(competition_code)

    if not initial_load:
        available_years = [available_years[0]]

    num_req = 0
    results = []
    to_retry = []
    # retrieve years to retry resource download for
    if res_list:
        to_retry = [res[1][-4:] for res in res_list]

    for yr in available_years:
        # Up to 10 calls per min with a free license.
        if num_req == 10:
            num_req = 0
            time.sleep(60)
        if not to_retry or yr in to_retry:
            res = api_resource_get(resource, competition_code, yr)
            results.append(res)
            num_req += 1

    return results
