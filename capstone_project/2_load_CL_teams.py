"""Script to read json file(s) with team data, clean & enhance data, and write transformed data to a json file.
"""
from football_data_file_read import read_resources
from football_data_file_read import competition_code
import re

RE_D = re.compile('\d')


def has_digits(string):
    return RE_D.search(string)


def parse_city(address):
    """Parse city from address string."""
    adr = [item.strip() for item in address.split() if item and not has_digits(item)]
    if adr:
        return adr[-1]
    else:
        return ''


if __name__ == '__main__':
    cl_code = competition_code('UEFA Champions League')

    teams = read_resources('teams', cl_code)

    # Add 2 new columns with team city and country.
    teams['city'] = teams.apply(lambda row: parse_city(row['address']), axis=1)
    teams['country'] = teams.apply(lambda row: row['area']['name'], axis=1)

    teams_clean = teams[['id', 'name', 'shortName', 'tla', 'city', 'country']]

    filename = cl_code + '_teams_full_list.json'
    with open(filename, 'w') as f:
        teams_clean.to_json(f, orient="records", indent=2)
