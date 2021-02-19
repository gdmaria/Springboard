"""Script for automated extraction, transformation, and load of football and weather data.
"""
import logging
import time
import api_resources as ar
import weather_data as wd
import resources_cleanup as rc
import football_data_load as fdl


MAX_ATTEMPTS = 3
WAIT = 10


def logger_configure():
    """Configure logger for automated pipeline."""
    log_file_name = 'football_data.log'
    log_football_data = logging.getLogger("football_data")
    log_football_data.setLevel(logging.INFO)
    file_handler = logging.FileHandler(log_file_name)
    formatter = logging.Formatter('%(asctime)s %(levelname)8s %(name)s | %(message)s',
                                  "%Y-%m-%d %H:%M:%S")
    file_handler.setFormatter(formatter)
    log_football_data.addHandler(file_handler)

    return log_football_data


def main(mdb, competition_name, initial_load):
    """Run automated pipeline.

    Parameters
    ----------
    mdb : client for a MongoDB instance
        Target MongoDB client.

    competition_name : str
        Football competition name.

    initial_load : bool
        INITIAL RUN flag.
        When True, loads competitions, seasons, and teams, matches, and weather reports for all seasons.
        When False, loads teams, matches, and weather reports for current season only.
    """
    log_football_data = logger_configure()
    log_football_data.info("STARTING DATA PIPELINE | MODE: {}".format("INITIAL RUN" if initial_load else "DAILY RUN"))

    # Data extraction
    log_football_data.info("STARTING DATA EXTRACTION | MODE: {}".format("INITIAL RUN" if initial_load else "DAILY RUN"))

    # STEP 1: Get competitions
    if initial_load:
        log_football_data.info("STEP 1: Starting competitions download.")
        attempts = 0
        while attempts < MAX_ATTEMPTS:
            try:
                # raise Exception('Fake exception to test retries.')
                cmp_cnt = ar.competitions_get()
                log_football_data.info("STEP 1: Competitions download completed. 1 file, {} records.".format(cmp_cnt))
                break
            except Exception as e:
                attempts += 1
                log_football_data.warning("STEP 1: DATA EXTRACTION - Attempt {} of {} failed."
                                          .format(attempts, MAX_ATTEMPTS))
                if attempts == MAX_ATTEMPTS:
                    log_football_data.critical("STEP 1: Competitions download failed, data load terminated. {}."
                                               .format(str(e)))
                    log_football_data.warning("STEP 1: DATA EXTRACTION TERMINATED")
                    return  # terminate program if this step fails
                time.sleep(WAIT)

    if initial_load:
        # STEP 2: Get seasons
        log_football_data.info("STEP 2: Starting seasons download.")
        attempts = 0
        while attempts < MAX_ATTEMPTS:
            try:
                season_cnt = ar.seasons_get(competition_name)
                log_football_data.info("STEP 2: Seasons download completed. 1 file, {} records.".format(season_cnt))
                break
            except Exception as e:
                attempts += 1
                log_football_data.warning("STEP 2: DATA EXTRACTION - Attempt {} of {} failed."
                                          .format(attempts, MAX_ATTEMPTS))
                if attempts == MAX_ATTEMPTS:
                    log_football_data.critical("STEP 2: Seasons download failed, data load terminated. {}."
                                               .format(str(e)))
                    log_football_data.warning("STEP 2: DATA EXTRACTION TERMINATED")
                    return  # terminate program if this step fails
                time.sleep(WAIT)

    # STEP 3: Get teams
    log_football_data.info("STEP 3: Starting teams download.")
    try:
        attempts = 0
        res_list = []
        while attempts < MAX_ATTEMPTS:
            res_list = ar.resources_get('teams', competition_name, res_list, initial_load)

            # Fake exception
            # if attempts == 0:
            #     res_list[0] = False, res_list[0][1], res_list[0][2]

            files_success = len([f for f in res_list if f[0]])
            files_total = len(res_list)
            log_football_data.info("STEP 3: Teams download completed. {} files of {} downloaded successfully."
                                   .format(files_success, files_total))

            for res in res_list:
                if res[0]:
                    log_football_data.info("STEP 3: Teams file {} download completed. {} records."
                                           .format(res[1], res[2]))
                else:
                    log_football_data.warning("STEP 3: Teams file {} download failed. {}.".format(res[1], res[2]))

            if files_success == files_total:
                break
            else:
                attempts += 1
                res_list = [res for res in res_list if not res[0]]  # failed calls only
                log_football_data.warning("STEP 3: DATA EXTRACTION - Attempt {} of {} failed."
                                          .format(attempts, MAX_ATTEMPTS))
                time.sleep(WAIT)

    except Exception as e:
        log_football_data.error("STEP 3: Teams download failed. {}.".format(str(e)))

    # STEP 4: Get matches
    log_football_data.info("STEP 4: Starting matches download.")
    try:
        attempts = 0
        res_list = []
        while attempts < MAX_ATTEMPTS:
            res_list = ar.resources_get('matches', competition_name, res_list, initial_load)
            files_success = len([f for f in res_list if f[0]])
            files_total = len(res_list)
            log_football_data.info("STEP 4: Matches download completed. {} files of {} downloaded successfully."
                                   .format(files_success, files_total))

            for res in res_list:
                if res[0]:
                    log_football_data.info("STEP 4: Matches file {} download completed. {} records."
                                           .format(res[1], res[2]))
                else:
                    log_football_data.warning("STEP 4: Matches file {} download failed. {}.".format(res[1], res[2]))

            if files_success == files_total:
                break
            else:
                attempts += 1
                res_list = [res for res in res_list if not res[0]]  # failed calls only
                log_football_data.warning("STEP 4: DATA EXTRACTION - Attempt {} of {} failed."
                                          .format(attempts, MAX_ATTEMPTS))
                time.sleep(WAIT)

    except Exception as e:
        log_football_data.error("STEP 4: Matches download failed. {}.".format(str(e)))

    # STEP 5: Get weather reports
    log_football_data.info("STEP 5: Starting weather reports download.")
    try:
        res_list = wd.weather_report_get(competition_name, initial_load)
        log_football_data.info("STEP 5: Weather reports download completed. {} files of {} downloaded successfully."
                               .format(len([f for f in res_list if f[0]]), len(res_list)))

        for res in res_list:
            if res[0]:
                log_football_data.info("STEP 5: Weather report {} download completed.".format(res[1]))
            else:
                log_football_data.warning("STEP 5: Weather report {} download failed: {}.".format(res[1], res[2]))

    except Exception as e:
        log_football_data.warning("STEP 5: Weather reports download failed. {}.".format(str(e)))

    log_football_data.info("DATA EXTRACTION COMPLETED")

    # Data transformation
    log_football_data.info("STARTING DATA TRANSFORMATION | MODE: {}"
                           .format("INITIAL RUN" if initial_load else "DAILY RUN"))

    # STEP 1: Teams cleanup
    log_football_data.info("STEP 1: Starting teams cleanup.")
    try:
        file_cnt = rc.resource_cleanup('teams', competition_name, initial_load)
        log_football_data.info("STEP 1: Teams cleanup completed. {} files processed.".format(file_cnt))
    except Exception as e:
        log_football_data.error("STEP 1: Teams cleanup failed. {}.".format(str(e)))

    # STEP 2: Matches cleanup
    log_football_data.info("STEP 2: Starting matches cleanup.")
    try:
        file_cnt = rc.resource_cleanup('matches', competition_name, initial_load)
        log_football_data.info("STEP 2: Matches cleanup completed. {} files processed.".format(file_cnt))
    except Exception as e:
        log_football_data.error("STEP 2: Matches cleanup failed. {}.".format(str(e)))

    log_football_data.info("DATA TRANSFORMATION COMPLETED")

    # Data load
    log_football_data.info("STARTING DATA LOAD | MODE: {}"
                           .format("INITIAL RUN" if initial_load else "DAILY RUN"))

    # STEP 1: Load competitions
    if initial_load:
        log_football_data.info("STEP 1: Starting competitions upload.")
        try:
            res = fdl.competitions_load(mdb)
            if res[0]:
                log_football_data.info("STEP 1: Competitions upload completed. {}.".format(res[2]))
            else:
                log_football_data.error("STEP 1: Competitions upload failed. {}.".format(res[2]))
        except Exception as e:
            log_football_data.error("STEP 1: Competitions upload failed. {}.".format(str(e)))

    # STEP 2: Load seasons
    if initial_load:
        log_football_data.info("STEP 2: Starting seasons upload.")
        try:
            res = fdl.seasons_load(mdb, competition_name)
            if res[0]:
                log_football_data.info("STEP 2: Seasons upload completed. {}.".format(res[2]))
            else:
                log_football_data.error("STEP 2: Seasons upload failed. {}.".format(res[2]))
        except Exception as e:
            log_football_data.error("STEP 2: Seasons upload failed. {}.".format(str(e)))

    # STEP 3: Load weather station mapping
    if initial_load:
        log_football_data.info("STEP 3: Starting stations upload.")
        try:
            res = fdl.stations_load(mdb)
            if res[0]:
                log_football_data.info("STEP 3: Stations upload completed. {}.".format(res[2]))
            else:
                log_football_data.error("STEP 3: Stations upload failed. {}.".format(res[2]))
        except Exception as e:
            log_football_data.error("STEP 3: Stations upload failed. {}.".format(str(e)))

    # STEP 4: Load teams
    log_football_data.info("STEP 4: Starting teams upload.")
    try:
        res_list = fdl.resource_load(mdb, 'teams', competition_name, initial_load)
        log_football_data.info("STEP 4: Teams upload completed. {} files of {} downloaded successfully."
                               .format(len([f for f in res_list if f[0]]), len(res_list)))

        for res in res_list:
            if res[0]:
                log_football_data.info("STEP 4: Teams file {} upload completed. {}.".format(res[1], res[2]))
            else:
                log_football_data.warning("STEP 4: Teams file {} upload failed. {}.".format(res[1], res[2]))

    except Exception as e:
        log_football_data.error("STEP 4: Teams upload failed. {}.".format(str(e)))

    # STEP 5: Load matches
    log_football_data.info("STEP 5: Starting matches upload.")
    try:
        res_list = fdl.resource_load(mdb, 'matches', competition_name, initial_load)
        log_football_data.info("STEP 5: Matches upload completed. {} files of {} downloaded successfully."
                               .format(len([f for f in res_list if f[0]]), len(res_list)))

        for res in res_list:
            if res[0]:
                log_football_data.info("STEP 5: Matches file {} upload completed. {}.".format(res[1], res[2]))
            else:
                log_football_data.warning("STEP 5: Matches file {} upload failed. {}.".format(res[1], res[2]))

    except Exception as e:
        log_football_data.error("STEP 5: Matches upload failed. {}.".format(str(e)))

    # STEP 6: Load weather reports
    log_football_data.info("STEP 6: Starting weather reports upload.")
    try:
        res_list = fdl.weather_report_load(mdb, competition_name, initial_load)
        log_football_data.info("STEP 6: Weather reports upload completed. {} files of {} downloaded successfully."
                               .format(len([f for f in res_list if f[0]]), len(res_list)))

        for res in res_list:
            if res[0]:
                log_football_data.info("STEP 6: Weather report file {} upload completed. {}.".format(res[1], res[2]))
            else:
                log_football_data.warning("STEP 6: Weather report file {} upload failed. {}.".format(res[1], res[2]))

    except Exception as e:
        log_football_data.error("STEP 5: Weather reports upload failed. {}.".format(str(e)))

    log_football_data.info("DATA LOAD COMPLETED")

    log_football_data.info("CLOSING DATA PIPELINE | MODE: {}".format("INITIAL RUN" if initial_load else "DAILY RUN"))


if __name__ == '__main__':
    football_db = fdl.db_connect('footballDB')
    main(mdb=football_db, competition_name='UEFA Champions League', initial_load=True)
