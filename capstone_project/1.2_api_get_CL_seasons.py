"""Script to get all seasons of a competition from the https://www.football-data.org/ API.
"""
from football_data_api_call import *
from football_data_file_read import competition_code


def api_get_seasons(competition_code):
    url = '/v2/competitions/' + competition_code
    response = api_call(url)
    with open('CL_seasons.json', 'w') as f:
        json.dump(response, f, indent=2)


if __name__ == '__main__':
    cl_code = competition_code('UEFA Champions League')
    api_get_seasons(cl_code)
