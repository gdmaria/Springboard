import mysql.connector
import csv
import logging


def logger_configure():
    """Configure logger for automated pipeline."""
    log_file_name = 'event_ticket_system.log'
    log_football_data = logging.getLogger("event_ticket_system")
    log_football_data.setLevel(logging.INFO)
    file_handler = logging.FileHandler(log_file_name)
    formatter = logging.Formatter('%(asctime)s %(levelname)8s %(name)s | %(message)s',
                                  "%Y-%m-%d %H:%M:%S")
    file_handler.setFormatter(formatter)
    log_football_data.addHandler(file_handler)

    return log_football_data


def get_db_connection():
    dbname = 'event_ticket_system'
    connection = mysql.connector.connect(user='<username>',
                                         password='<password>',
                                         host='<hostname>',
                                         port='3306',
                                         database=dbname)

    return connection


def load_third_party(connection, file_path_csv):
    cursor = connection.cursor()

    with open(file_path_csv, 'r') as f:
        reader = csv.reader(f)
        for row in reader:
            cursor.execute("""INSERT INTO ticket_sales(
                              ticket_id,
                              trans_date, 
                              event_id, 
                              event_name, 
                              event_date,
                              event_type,
                              event_city,
                              customer_id,
                              price,
                              num_tickets
                              )
                              VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                           """, row)

    # [Iterate through the CSV file and execute insert statement]
    connection.commit()
    cursor.close()
    return


def query_popular_events(connection):
    # Get the most popular events in the past year
    sql_statement = """
                        WITH event_sales A
                        (
                            SELECT event_id, event_name, COUNT(ticket_id) AS tickets_sold
                            FROM event_ticket_system.ticket_sales
                            WHERE event_date >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 YEAR, '%Y/%m/%d') 
                            GROUP BY event_id
                        ),
                        rnk AS
                        (
                            SELECT event_id, event_name, tickets_sold, RANK() OVER(ORDER BY tickets_sold DESC) AS rnk
                            FROM event_sales
                        )
                        SELECT event_id, event_name
                        FROM rnk
                        WHERE rnk.rnk = 1
                        ORDER BY event_name;    
                    """
    cursor = connection.cursor()
    cursor.execute(sql_statement)
    records = cursor.fetchall()
    cursor.close()

    return records


def main():
    log_event_ticket_system = logger_configure()
    log_event_ticket_system.info("STARTING DATA PIPELINE")

    try:
        log_event_ticket_system.info("STEP 1: Connecting to database.")
        ticket_db = get_db_connection()
        log_event_ticket_system.info("STEP 1: Connection to database established.")
    except Exception as e:
        log_event_ticket_system.critical("STEP 1: Error while connecting to database, data load terminated. {}."
                                         .format(str(e)))
        return

    try:
        log_event_ticket_system.info("STEP 2: Loading data to database.")
        load_third_party(ticket_db, 'third_party_sales_1.csv')
        log_event_ticket_system.info("STEP 2: Loading data to database completed.")
    except Exception as e:
        log_event_ticket_system.critical("STEP 2: Error while loading data to database, data load terminated. {}."
                                         .format(str(e)))
        return

    try:
        log_event_ticket_system.info("STEP 3: Retrieving most popular event(s) from database.")
        res = query_popular_events(ticket_db)
        log_event_ticket_system.info(res)
        log_event_ticket_system.info("STEP 3: Retrieving most popular event(s) from database completed.")
    except Exception as e:
        log_event_ticket_system.critical("STEP 2: Error while retrieving most popular event(s) from database. {}."
                                         .format(str(e)))


if __name__ == '__main__':
    main()
