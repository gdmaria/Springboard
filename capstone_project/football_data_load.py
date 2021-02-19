"""Script to load json files with transformed data to a target MongoDB.
"""
import os
import re
import mongo_db
from football_data_file import competition_code_get, current_season_get
from weather_data import weather_report_list


def db_connect(dbname):
    """Upload competitions from json file to target MongoDB.

    Parameters
    ----------
    dbname : str
        Target MongoDB name.

    Returns
    -------
        client object for a MongoDB instance
    """
    db = mongo_db.MongoDB(dbname)
    db.db_connect()

    return db


def competitions_load(mdb):
    """Upload competitions from json file to target MongoDB.

    Parameters
    ----------
    mdb : client for a MongoDB instance
        Target MongoDB client.

    Returns
    -------
        dict ({'inserted_count': int})
    """
    return mdb.collection_insert('competitions', 'competitions.json', override=True)


def seasons_load(mdb, competition_name):
    """Upload seasons from json file to target MongoDB.

    Parameters
    ----------
    mdb : client for a MongoDB instance
        Target MongoDB client.

    competition_name : str
        Competition name.

    Returns
    -------
        dict ({'inserted_count': int})
    """
    competition_code = competition_code_get(competition_name)
    filename = competition_code + '_seasons.json'

    return mdb.collection_insert('seasons', filename, keys=['seasons'], override=True)


def stations_load(mdb):
    """Upload city to weather station mapping from json file to target MongoDB.

    Parameters
    ----------
    mdb : client for a MongoDB instance
        Target MongoDB client.

    Returns
    -------
        dict ({'inserted_count': int})
    """
    return mdb.collection_insert('stations', 'city_weather_station_map.json', override=True)


def resource_load(mdb, resource, competition_name, initial_load=False):
    """Upload clean team/match data from json file to target MongoDB.

    Parameters
    ----------
    mdb : client for a MongoDB instance
        Target MongoDB client.

    resource : str
        Resource category ('teams' or 'matches').

    competition_name : str
        Competition name.

    initial_load : bool (optional, default=False)
        Initial load flag. When True, loads resources for all seasons vs. latest season only.

    Returns
    -------
        list((bool, str, dict/str))
            (download status: True/False, filename, dict with the results of a PyMongo operation/error)
    """
    competition_code = competition_code_get(competition_name)

    files_dir = os.getcwd()
    filename_kwd = competition_code + '\_' + resource + '\_'

    if initial_load:
        re_f_name = re.compile(filename_kwd + '\d{4}' + '\_clean.json')
    else:
        current_season_start_year = current_season_get(competition_code)[0]
        re_f_name = re.compile(filename_kwd + current_season_start_year + '\_clean.json')

    file_list = [file_name for file_name in os.listdir(files_dir)
                 if re_f_name.search(file_name) and os.path.getsize(os.path.join(files_dir, file_name)) > 1024]

    results = []
    collection = resource
    if resource == 'teams':
        for filename in file_list:
            res = mdb.collection_upsert(collection, ['id'], filename)
            results.append(res)
    elif resource == 'matches':
        if initial_load:
            mdb.collection_drop(collection)
            for filename in file_list:
                res = mdb.collection_insert(collection, filename, override=False)
                results.append(res)
        else:
            for filename in file_list:
                res = mdb.collection_upsert(collection, ['id'], filename)
                results.append(res)

    return results


def weather_report_load(mdb, competition_name, initial_load=False):
    competition_code = competition_code_get(competition_name)

    reports = weather_report_list(competition_code, initial_load)

    file_list = [st + '_' + yr + '.csv' for yr, st in reports]  # \d +\_\d{4}\.csv

    results = []
    collection = 'weather_reports'
    if initial_load:
        mdb.collection_drop(collection)
        for filename in file_list:
            res = mdb.collection_insert(collection, filename, override=False)
            results.append(res)
    else:
        for filename in file_list:
            res = mdb.collection_upsert(collection, ['STATION', 'DATE'], filename)
            results.append(res)

    return results


if __name__ == '__main__':
    football_db = db_connect('footballDB')

    # print(competitions_load(football_db))
    # print(seasons_load(football_db, 'UEFA Champions League'))
    # print(stations_load(football_db))

    # print(resource_load(football_db, 'teams', 'UEFA Champions League', False))
    # print(resource_load(football_db, 'matches', 'UEFA Champions League', True))

    print(weather_report_load(football_db, 'UEFA Champions League', True))
