"""Module containing functions for getting football data from the https://www.football-data.org/ API.
"""
import http.client
import json
import time


def api_call(uri):
    """
    Get specified resource from the API.

    Parameters
    ----------
    uri : str
        Resource URI.

    Returns
    -------
        json object.
    """
    connection = http.client.HTTPConnection('api.football-data.org')
    headers = {'X-Auth-Token': '8aed48af305e4e8f86bc513632c675e3'}
    connection.request('GET', uri, None, headers)
    response = json.loads(connection.getresponse().read().decode())
    return response


def api_get_resource(resource, competition_code, season_year):
    """
    Write API response for specified resource to json file.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').
    competition_code : str
        Competition code.
    season_year : str
        Season year in yyyy format.
    """
    uri = '/v2/competitions/' + competition_code + '/' + resource + '?season=' + season_year
    response = api_call(uri)
    filename = competition_code + '_' + resource + '_' + season_year + '.json'
    with open(filename, 'w') as f:
        json.dump(response, f, indent=2)


def api_get_resources(resource, competition_code):
    """
    Write API response for specified resource to json file.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').
    competition_code : str
        Competition code.
    """
    # Get the list of all available seasons for the competition.
    filename = competition_code + '_seasons.json'
    with open(filename, 'r') as f:
        competition_seasons = json.load(f)

    code = competition_code
    seasons = competition_seasons['seasons']

    num_req = 0
    # Only 3 latest seasons are available with a free license.
    for s in seasons[:3]:
        # Up to 10 calls per min with a free license.
        if num_req == 10:
            num_req = 0
            time.sleep(60)
        yr = s['startDate'][:4]
        api_get_resource(resource, code, yr)
        num_req += 1
