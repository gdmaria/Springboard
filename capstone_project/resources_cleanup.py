"""Script to read json file(s) with team/match data, clean & enhance data, and write transformed data to json file(s).
"""
import re
import json
import os
import pandas as pd
from football_data_file import competition_code_get, current_season_get


RE_D = re.compile('\d')


def has_digits(string):
    return RE_D.search(string)


def city_parse(address):
    """Parse city from address string."""
    adr = [item.strip() for item in address.split() if item and not has_digits(item)]
    if adr:
        return adr[-1]
    else:
        return ''


def file_read(resource, filename):
    """Read json file into pandas DataFrame.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').

    filename : str
        File name.

    Returns
    -------
        pandas DataFrame
    """
    data = json.load(open(filename))
    df = pd.DataFrame(data[resource])
    df['code'] = data['competition']['code']

    return df


def match_cleanup(filename):
    """Read json file with match data, clean & enhance data, and write transformed data to json file.

    Parameters
    ----------
    filename : str
        File name.
    """
    resource = 'matches'
    match = file_read(resource, filename)

    match['season_id'] = match.apply(lambda row: row['season']['id'], axis=1)
    match['winner'] = match.apply(lambda row: row['score']['winner'], axis=1)
    match['duration'] = match.apply(lambda row: row['score']['duration'], axis=1)
    match['fullTime_homeTeam'] = match.apply(lambda row: row['score']['fullTime']['homeTeam'], axis=1)
    match['fullTime_awayTeam'] = match.apply(lambda row: row['score']['fullTime']['awayTeam'], axis=1)
    match['halfTime_homeTeam'] = match.apply(lambda row: row['score']['halfTime']['homeTeam'], axis=1)
    match['halfTime_awayTeam'] = match.apply(lambda row: row['score']['halfTime']['awayTeam'], axis=1)
    match['extraTime_homeTeam'] = match.apply(lambda row: row['score']['extraTime']['homeTeam'], axis=1)
    match['extraTime_awayTeam'] = match.apply(lambda row: row['score']['extraTime']['awayTeam'], axis=1)
    match['penalties_homeTeam'] = match.apply(lambda row: row['score']['penalties']['homeTeam'], axis=1)
    match['penalties_awayTeam'] = match.apply(lambda row: row['score']['penalties']['awayTeam'], axis=1)
    match['homeTeam_id'] = match.apply(lambda row: row['homeTeam']['id'], axis=1)
    match['awayTeam_id'] = match.apply(lambda row: row['awayTeam']['id'], axis=1)

    match_clean = match[['id', 'utcDate', 'season_id', 'code', 'status', 'stage', 'group',
                         'homeTeam_id', 'awayTeam_id']].copy()
    match_clean[['fullTime_homeTeam', 'fullTime_awayTeam',
                 'halfTime_homeTeam', 'halfTime_awayTeam',
                 'extraTime_homeTeam', 'extraTime_awayTeam',
                 'penalties_homeTeam', 'penalties_awayTeam']] = \
        match[['fullTime_homeTeam', 'fullTime_awayTeam',
               'halfTime_homeTeam', 'halfTime_awayTeam',
               'extraTime_homeTeam', 'extraTime_awayTeam',
               'penalties_homeTeam', 'penalties_awayTeam']].fillna(0).astype(int)

    filename_clean = filename[:-5] + '_clean.json'
    with open(filename_clean, 'w') as f:
        match_clean.to_json(f, orient="records", indent=2)


def team_cleanup(filename):
    """Read json file with team data, clean & enhance data, and write transformed data to json file.

    Parameters
    ----------
    filename : str
        File name.
    """
    resource = 'teams'
    team = file_read(resource, filename)

    # Add 2 new columns with team city and country.
    team['city'] = team.apply(lambda row: city_parse(row['address']), axis=1)
    team['country'] = team.apply(lambda row: row['area']['name'], axis=1)

    team_clean = team[['id', 'code', 'name', 'shortName', 'tla', 'city', 'country']]

    filename_clean = filename[:-5] + '_clean.json'
    with open(filename_clean, 'w') as f:
        team_clean.to_json(f, orient="records", indent=2)


def resource_cleanup(resource, competition_name, initial_load=False):
    """Initiate cleanup of relevant json file(s) with team/match data of a competition.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').

    competition_name : str
        Competition name.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads resources for all seasons vs. latest season only.

    Returns
    -------
        int (number of files processed)
    """
    competition_code = competition_code_get(competition_name)

    files_dir = os.getcwd()
    filename_kwd = competition_code + '_' + resource + '_'

    if initial_load:
        re_f_name = re.compile(filename_kwd + '\d{4}\.json')
    else:
        current_season_start_year = current_season_get(competition_code)[0]
        re_f_name = re.compile(filename_kwd + current_season_start_year + '.json')

    file_list = [file_name for file_name in os.listdir(files_dir)
                 if re_f_name.search(file_name) and os.path.getsize(os.path.join(files_dir, file_name)) > 1024]

    if resource == 'teams':
        for filename in file_list:
            team_cleanup(filename)
    elif resource == 'matches':
        for filename in file_list:
            match_cleanup(filename)

    return len(file_list)


if __name__ == '__main__':
    resource_cleanup('teams', 'UEFA Champions League', False)
    resource_cleanup('matches', 'UEFA Champions League', True)
