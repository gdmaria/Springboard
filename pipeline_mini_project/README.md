# Summary  
Pipeline mini-project.  

## Prerequisites (installation required)  
* mysql-connector-python  

## Project Files  
1. **pipeline.py** - Master script for running the pipeline.  
2. **db.sql** - Script to create target database and table.  

Other files:
* **third_party_sales_1.csv** - File with ticket sales data.  
* **event_ticket_system.log** - Log file (created automatically).  

## Usage notes:
* Run **db.sql** in MySQL Workbench.
* In **pipeline.py** specify correct
  * user='<username>'
  * password='<password>'
  * host='<hostname>'
  * port='3306'
* To test the pipeline, run **pipeline.py**.

## Other notes:
* Provided csv file didn't match provided table schema (event_addr field missing in the csv file).
* Provided table schema had errors (trans_date had INT type vs. date).
* Changed suggested statistical function from "Get the most popular ticket in the past month" to "Get the most popular event in the past year" to get some meaningful results.