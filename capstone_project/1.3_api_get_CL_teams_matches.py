"""Script to get all teams and matches for all seasons of a competition from the https://www.football-data.org/ API.
"""
from football_data_api_call import *
from football_data_file_read import competition_code


if __name__ == '__main__':
    cl_code = competition_code('UEFA Champions League')

    api_get_resources('teams', cl_code)
    api_get_resources('matches', cl_code)
