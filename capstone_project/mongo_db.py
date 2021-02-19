"""Module containing a class for working with MongoDB.

   The "dnspython" module must be installed to use mongodb+srv:// URIs
"""
import json
import pandas as pd
from pymongo import MongoClient, results


class MongoDBException(Exception):
    pass


class FileTypeException(Exception):
    pass


class MongoDB:
    """Class for working with MongoDB"""
    def __init__(self, dbname):
        self.dbname = dbname
        self._database = None

    def db_connect(self):
        """Connect to target MongoDB."""
        username = 'dbUser'
        pwd = '31415926'

        client = MongoClient('mongodb+srv://' + username + ':' + pwd +
                             '@cluster1.jnecv.mongodb.net/' + self.dbname + '?retryWrites=true&w=majority')

        self._database = client[self.dbname]

    def collection_drop(self, collection):
        if not self._database:
            raise MongoDBException('DB connection not initiated')

        c = self._database[collection]
        c.drop()

    def collection_insert(self, collection, filename, keys=None, override=False):
        """Insert data from file to MongoDB collection.

        Parameters
        ----------
        collection : str
            Target MongoDB collection name. If it doesn't exist, it will be created.

        filename : str
            File name (.json or .csv).

        keys : list (optional, default=False)
            List of keys which form a path to a specific entry in resulting json.

        override : bool (optional, default=False)
            A flag indicating whether target collection should be dropped before the insert.

        Returns
        -------
            if no exceptions: bool, str, dict (True, filename, dict with the results of a PyMongo operation)
            if exception: bool, str, str (False, filename, error)
        """
        try:
            if not self._database:
                raise MongoDBException('DB connection not initiated')

            c = self._database[collection]

            file_data = MongoDB.file_read_to_json(filename, keys)

            if override:
                self.collection_drop(collection)
            if isinstance(file_data, list):
                res = c.insert_many(file_data)
            else:
                res = c.insert_one(file_data)

            return True, filename, MongoDB.results(res)
        except Exception as e:
            return False, filename, str(e)

    def collection_upsert(self, collection, keywords, filename, keys=None):
        """Upsert data from file to MongoDB collection.

        Parameters
        ----------
        collection : str
            Target MongoDB collection name. If it doesn't exist, it will be created.

        keywords : list
            Keywords used in in replace_one operation filter.

        filename : str
            File name (.json or .csv).

        keys : list
            List of keys which form a path to a specific entry in resulting json.

        Returns
        -------
            if no exceptions: bool, str, dict (True, filename, dict with the results of a PyMongo operation)
            if exception: bool, str, str (False, filename, error)
        """
        try:
            if not self._database:
                raise MongoDBException('DB connection not initiated')

            file_data = MongoDB.file_read_to_json(filename, keys)

            c = self._database[collection]

            if c.count_documents({}) == 0:
                if isinstance(file_data, list):
                    res = c.insert_many(file_data)
                else:
                    res = c.insert_one(file_data)

                return True, filename, MongoDB.results(res)
            else:
                res_list = []
                for record in file_data:
                    upd_filter = {kwd: record[kwd] for kwd in keywords}
                    res = c.replace_one(upd_filter, record, upsert=True)
                    res_list.append(res)

                return True, filename, MongoDB.results(res_list)
        except Exception as e:
            return False, filename, str(e)

    @staticmethod
    def file_read_to_json(filename, keys=None):
        """Read json or csv file and return json object with the file content or a portion of the file content .

        Parameters
        ----------
        filename : str
            File name (.json or .csv).

        keys : list
            List of keys which form a path to a specific entry in resulting json.

        Returns
        -------
            json object
        """
        if filename.endswith('.json'):
            with open(filename) as f:
                file_data = json.load(f)
        elif filename.endswith('.csv'):
            df = pd.read_csv(filename)
            cols = [col for col in df.columns if
                    col not in ['Unnamed: 0', 'TEMP_ATTRIBUTES', 'DEWP_ATTRIBUTES', 'SLP_ATTRIBUTES', 'STP_ATTRIBUTES',
                                'VISIB_ATTRIBUTES', 'WDSP_ATTRIBUTES', 'MAX_ATTRIBUTES', 'MIN_ATTRIBUTES',
                                'PRCP_ATTRIBUTES']]
            df_clean = df[cols]
            json_str = df_clean.to_json(orient="records", indent=2)
            file_data = json.loads(json_str)
        else:
            raise FileTypeException('Unsupported file type')

        if keys:
            for key in keys:
                file_data = file_data[key]

        return file_data

    @staticmethod
    def results(res):
        """Return dict with the results of a PyMongo operation.

        Parameters
        ----------
        res : pymongo.results or list(pymongo.results)
            An object (or a list of objects) of pymongo.results class containing results of a PyMongo operation.

        Returns
        -------
            dict
        """
        if isinstance(res, results.InsertManyResult):
            return {'inserted_count': len(res.inserted_ids)}

        if isinstance(res, results.InsertOneResult):
            return {'inserted_count': 1}

        if isinstance(res, results.UpdateResult):
            return {'matched_count': res.matched_count, 'modified_count': res.modified_count, 'upserted_count': 1}

        # list[results.UpdateResult] is returned by self.collection_upsert
        elif isinstance(res, list):
            matched_count = modified_count = upserted_count = 0

            for r in res:
                matched_count += r.matched_count if r.matched_count else 0
                modified_count += r.modified_count if r.modified_count else 0
                upserted_count += 1 if r.upserted_id else 0

            return {'matched_count': matched_count, 'modified_count': modified_count, 'upserted_count': upserted_count}


if __name__ == '__main__':
    mdb = MongoDB('footballDB')
    mdb.db_connect()

    # print(mdb.collection_insert('competitions', 'competitions.json', override=True))
    # print(mdb.collection_insert('stations', 'city_weather_station_map.json', override=True))
    # print(mdb.collection_insert('seasons', 'CL_seasons.json', keys=['seasons'], override=True))

    # print(mdb.collection_upsert('teams', ['id'], 'CL_teams_2018_clean.json'))
    # print(mdb.collection_upsert('teams', ['id'], 'CL_teams_2019_clean.json'))
    # print(mdb.collection_upsert('teams', ['id'], 'CL_teams_2020_clean.json'))

    # print(mdb.collection_insert('matches', ['id'], 'CL_matches_2018_clean.json'))
    # print(mdb.collection_insert('matches', ['id'], 'CL_matches_2019_clean.json'))
    # print(mdb.collection_insert('matches', ['id'], 'CL_matches_2020_clean.json'))

    # print(mdb.collection_insert('weather_reports', '08181099999_2018.csv'))
    # print(mdb.collection_upsert('weather_reports', ['STATION', 'DATE'], '08181099999_2018.csv'))
