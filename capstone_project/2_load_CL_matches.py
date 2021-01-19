"""Script to read json file(s) with match data, clean & enhance data, and write transformed data to a json file.
"""
from football_data_file_read import read_resources
from football_data_file_read import competition_code
import pandas as pd


if __name__ == '__main__':
    cl_code = competition_code('UEFA Champions League')

    matches = read_resources('matches', cl_code)

    matches['season_id'] = matches.apply(lambda row: row['season']['id'], axis=1)
    matches['winner'] = matches.apply(lambda row: row['score']['winner'], axis=1)
    matches['duration'] = matches.apply(lambda row: row['score']['duration'], axis=1)
    matches['fullTime_homeTeam'] = matches.apply(lambda row: row['score']['fullTime']['homeTeam'], axis=1)
    matches['fullTime_awayTeam'] = matches.apply(lambda row: row['score']['fullTime']['awayTeam'], axis=1)
    matches['halfTime_homeTeam'] = matches.apply(lambda row: row['score']['halfTime']['homeTeam'], axis=1)
    matches['halfTime_awayTeam'] = matches.apply(lambda row: row['score']['halfTime']['awayTeam'], axis=1)
    matches['extraTime_homeTeam'] = matches.apply(lambda row: row['score']['extraTime']['homeTeam'], axis=1)
    matches['extraTime_awayTeam'] = matches.apply(lambda row: row['score']['extraTime']['awayTeam'], axis=1)
    matches['penalties_homeTeam'] = matches.apply(lambda row: row['score']['penalties']['homeTeam'], axis=1)
    matches['penalties_awayTeam'] = matches.apply(lambda row: row['score']['penalties']['awayTeam'], axis=1)
    matches['homeTeam_id'] = matches.apply(lambda row: row['homeTeam']['id'], axis=1)
    matches['awayTeam_id'] = matches.apply(lambda row: row['awayTeam']['id'], axis=1)

    matches_clean = matches[['id', 'utcDate', 'season_id', 'status', 'stage', 'group',
                             'homeTeam_id', 'awayTeam_id']].copy()
    matches_clean[['fullTime_homeTeam', 'fullTime_awayTeam',
                   'halfTime_homeTeam', 'halfTime_awayTeam',
                   'extraTime_homeTeam', 'extraTime_awayTeam',
                   'penalties_homeTeam', 'penalties_awayTeam']] = \
        matches[['fullTime_homeTeam', 'fullTime_awayTeam',
                 'halfTime_homeTeam', 'halfTime_awayTeam',
                 'extraTime_homeTeam', 'extraTime_awayTeam',
                 'penalties_homeTeam', 'penalties_awayTeam']].fillna(0).astype(int)

    filename = cl_code + '_matches_full_list.json'
    with open(filename, 'w') as f:
        matches_clean.to_json(f, orient="records", indent=2)
