# Summary
This project's goal is to create a dataset combining soccer matches data and weather data.

## Resources
#### Football data
- https://www.football-data.org/
#### Weather Data
* https://www1.ncdc.noaa.gov/
  * Weather station list: https://www1.ncdc.noaa.gov/ 
  * Weather reports (per year): https://www.ncei.noaa.gov/data/global-summary-of-the-day/access/2020/

## Prerequisites (installation required)
* pyodbc
* pandas
* pymongo

## Project Files
1. **football_data_pipeline.py** - Master script for automated extraction, transformation, and load of football and weather data.
2. **api_resources.py** - Script to get competitions and season/team/match data of a competition from the https://www.football-data.org/ API.
3. **weather_data.py** - Script to get weather reports from https://www.ncei.noaa.gov/.
4. **resources_cleanup.py** - Script to read json file(s) with team/match data, clean & enhance data, and write transformed data to json file(s).
5. **football_data_load.py** - Script to load json files with transformed data to a target MongoDB.

Auxiliary modules:
* **football_data_api.py** - Module containing functions for getting football data from the https://www.football-data.org/ API.
* **football_data_file.py** - Module containing auxiliary functions for extracting data from json files.
* **mongo_db.py** - Module containing a class for working with MongoDB.

Other files:
* **pipeline_diagram.jpeg** - Diagram describing data flow.
* **football_data.log** - Log file containing detailed description of the steps performed and their results.

## Notes:
* To test the pipeline, run **football_data_pipeline.py**. By default, it's run with **initial_load=True**. 
  Change this argument to **False** in order to run the pipeline in a **daily** (incremental) mode. Some steps are not executed in the daily mode. 
  See **pipeline_diagram.jpeg** for more details.  
  <span style="color:red">**football_data_pipeline.py** must be run in **initial** mode the very first time.</span>

## Current Limitations
- Football data is retrieved for 1 league only (UEFA Champions League).  
- Only 3 latest seasons are available from the https://www.football-data.org/ API with a free license.  
- For testing purposes, city to weather station mapping is limited to just a few entries. This mapping is manually maintained.  
- Backload is not implemented, but it's safe to re-run the pipeline in **initial** mode when needed. 
- **Daily** mode brings data for the entire latest season because the resources provide seasonal/yearly data.  
- <span style="color:red">Retry is implemented for EXTRACTION phase only (steps 1-4).</span>


## Potential project scope changes
- Adding more leagues (competitions).
- Adding more seasons.
- Adding player (lineup) layer.
- Loading weather reports for ALL stations covering extended date range to increase data volume.
