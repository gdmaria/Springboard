"""Module containing functions for reading json files with football data into pandas DataFrame.
"""
import json
import pandas as pd
import os
import re


def competition_code(competition_name):
    """Read competition code from competitions.json searching by competition name."""
    with open('competitions.json', 'r') as f:
        competitions = json.load(f)
    code = next(c['code'] for c in competitions['competitions'] if c['name'] == competition_name)
    return code


def read_resources(resource, competition_code):
    """
    Read data from a corresponding json file into pandas DataFrame.

    Parameters
    ----------
    resource : str
        Resource category ('teams' or 'matches').
    competition_code : str
        Competition code.

    Returns
    -------
        pandas DataFrame object.
    """
    files_dir = os.getcwd()
    filename_kwd = competition_code + '_' + resource + '_'
    re_f_name = re.compile(filename_kwd + '\d{4}\.json')
    file_list = {file_name: os.path.getsize(os.path.join(files_dir, file_name))
                 for file_name in os.listdir(files_dir) if re_f_name.search(file_name)}

    df = pd.DataFrame.from_dict({'file_name': file_list.keys(), 'file_size': file_list.values()})
    df_valid = df[df.file_size > 1024]

    frames = []
    for index, row in df_valid.iterrows():
        filename = row['file_name']
        data = json.load(open(filename))
        f = pd.DataFrame(data[resource])
        frames.append(f)

    res_df = pd.concat(frames)
    res_df.drop_duplicates(subset=['id'], inplace=True)
    res_df.reset_index(drop=True, inplace=True)
    return res_df
