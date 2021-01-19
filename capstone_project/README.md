# Summary
This project's goal is to create a dataset combining soccer matches data and weather data.

## Resources
#### Football data
- https://www.football-data.org/
#### Weather Data
* https://www1.ncdc.noaa.gov/
  * Weather station list: https://www1.ncdc.noaa.gov/ 
  * Weather reports (per year): https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/2020/

## Project Files
**Note**: Files should be run in the order specified below.
1. **1.1_api_get_competitions.py**
   * Get all competitions from the https://www.football-data.org/ API.
   * Destination file: **competitions.json**
2. **1.2_api_get_CL_seasons.py**
   * Get all seasons of a competition from the https://www.football-data.org/ API.
   * Destination file: **CL_seasons.json**
3. **1.3_api_get_CL_teams_matches.py**
   * Get all teams and matches for all seasons of a competition from the https://www.football-data.org/ API.
   * Destination files: **CL_teams_\<yyyy>.json**, **CL_matches_\<yyyy>.json **
4. **1.4_weather_data_get.py**
   * Script to get weather reports from https://www.ncei.noaa.gov/.
   * Destination files: **\<weather_station_code>_\<yyyy>.csv**
5. Scripts to read json file(s) with team/match data, clean & enhance data, and write transformed data to a json file:
   * **2_load_CL_matches.py**: Destination file **CL_matches_full_list.json**
   * **2_load_CL_teams.py**: Destination file **CL_teams_full_list.json**

Auxiliary modules:
* **football_data_api_call.py**: Module containing functions for getting football data from the https://www.football-data.org/ API.
* **football_data_file_read.py**: Module containing functions for reading json files with football data into pandas DataFrame.

## Current Limitations
- Football data is retrieved for 1 league only (UEFA Champions League)
- Only 3 latest seasons are available from the https://www.football-data.org/ API with a free license.
- For testing purposes, city to weather station mapping (city_weather_station_map.json) is limited to just a few entries.
- Exception handling is not yet implemented.

## Potential project scope changes
- Adding more leagues (competitions)
- Adding more seasons
- Adding player (lineup) layer
- Loading weather reports for ALL stations covering extended date range to increase data volume
