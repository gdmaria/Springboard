"""Module containing auxiliary functions for extracting data from json files.
"""
import json


def competition_code_get(competition_name):
    """Retrieve competition code from competitions.json searching by competition name.

    Parameters
    ----------
    competition_name : str
        Competition name.

    Returns
    -------
        str (competition code; empty string if not found).
    """
    filename = 'competitions.json'
    with open(filename, 'r') as f:
        competitions = json.load(f)

    try:
        code = next(c['code'] for c in competitions if c['name'] == competition_name)
        return code
    except StopIteration as e:
        return ''


def current_season_get(competition_code):
    """Retrieve current season start and end years.

    Parameters
    ----------
    competition_code : str
        Competition code.

    Returns
    -------
        tuple (<current season start year>, <current season end year>)
    """
    filename = competition_code + '_seasons.json'
    with open(filename, 'r') as f:
        competition_seasons = json.load(f)

    return competition_seasons['currentSeason']['startDate'][:4], competition_seasons['currentSeason']['endDate'][:4]


def all_seasons_get(competition_code):
    """Get a list of all available seasons for the competition.

    Parameters
    ----------
    competition_code : str
        Competition code.

    Returns
    -------
        list
    """
    filename = competition_code + '_seasons.json'
    with open(filename, 'r') as f:
        competition_seasons = json.load(f)

    seasons = competition_seasons['seasons']

    # Only 3 latest seasons are available with a free license.
    available_years = [s['startDate'][:4] for s in seasons[:3]]

    return available_years

