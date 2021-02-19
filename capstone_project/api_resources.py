"""Script to get competitions and season/team/match data of a competition from the https://www.football-data.org/ API.
"""
import json
import football_data_api as fa
from football_data_file import competition_code_get


def competitions_get():
    """Get all competitions from the API and save to json file.

    Returns
    -------
        int (number of competition records)
    """
    url = '/v2/competitions'
    response = fa.api_call(url)
    with open('competitions.json', 'w') as f:
        json.dump(response['competitions'], f, indent=2)

    return len(response['competitions'])


def api_seasons_get(competition_code):
    """Get all seasons of a competition from the API and save to json file.

    Parameters
    ----------
    competition_code : str
        Competition code.

    Returns
    -------
        int (number of season records)
    """
    url = '/v2/competitions/' + competition_code
    response = fa.api_call(url)
    filename = competition_code + '_seasons.json'
    with open(filename, 'w') as f:
        json.dump(response, f, indent=2)

    return len(response['seasons'])


def seasons_get(competition_name):
    """Get all seasons of a competition by competition name.

    Parameters
    ----------
    competition_name : str
        Competition name.

    Returns
    -------
        int (number of season records)
    """
    competition_code = competition_code_get(competition_name)
    if competition_code:
        season_cnt = api_seasons_get(competition_code)
        return season_cnt
    else:
        raise Exception("Competition code for '{}' not found".format(competition_name))


def resources_get(resource, competition_name, res_list, initial_load=False):
    """Get team/match data of a competition from the API and save to json file(s).

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').

    competition_name : str
        Competition name.

    res_list : list
        List of tuples with the results of failed downloads from a previous attempt.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads team/match data for all seasons vs. latest season only.

    Returns
    -------
        int, list((str, int)) (number of created json files, list((file name, number of season records)))
    """
    competition_code = competition_code_get(competition_name)

    if competition_code:
        results = fa.api_resources_get(resource, competition_code, res_list, initial_load)
        return results
    else:
        raise Exception("Competition code for '{}' not found".format(competition_name))


if __name__ == '__main__':
    competitions_get()

    seasons_get('UEFA Champions League')

    resources_get('teams', 'UEFA Champions League', True)
    resources_get('matches', 'UEFA Champions League', True)
