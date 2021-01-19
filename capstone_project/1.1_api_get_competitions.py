"""Script to get all competitions from the https://www.football-data.org/ API.
"""
import json
from football_data_api_call import api_call


def api_get_competitions():
    url = '/v2/competitions'
    response = api_call(url)
    with open('competitions.json', 'w') as f:
        json.dump(response, f, indent=2)


if __name__ == '__main__':
    api_get_competitions()
