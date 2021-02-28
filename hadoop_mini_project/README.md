# Summary  
Hadoop mini-project.  

## Project Files  
Mappers  
1. **mapper1.py**  
2. **mapper2.py**  

Reducers  
3. **reducer1.py**  
4. **reducer2.py**  

Shell script for the map/redicce jobs
5. **map_reduce_job.sh**

Other files:
**data.csv** - File with source data.  

## Usage notes:
* To test in bash run the below command in bash shell:  
  cat data.csv | python3 mapper1.py | sort | python3 reducer1.py | python3 mapper2.py | sort | python3 reducer2.py
* To run the job in Hadoop:  
  hadoop fs -cat /test_data/map_reduce_job.sh|exec sh  
  **Note:** Change paths to jar and all files in the shell cript to reflect correct locations.


## Other notes:
* Provided csv file didn't have any cases with multiple accidents per vin number or multiple accidents per maker/year. Added these cases.  
* Provided instructions are incomplete and are missing key elements: 
  * Location of jar file - different from provided example and shouldn't be in Hadoop FS but in local FS.  
  * Location of .py files (mappers/reducers) - shouldn't be in Hadoop FS but in local FS.  
  * Location of .sh shell script - should be in Hadoop FS.  
  * Location of source and output files - should be in Hadoop FS.  
  * Multi-line command throws an error:  
    hadoop jar /usr/local/hadoop/contrib/streaming/hadoop-*streaming*.jar \
    -file autoinc_mapper1.py -mapper autoinc_mapper1.py \
    -file autoinc_reducer1.py -reducer autoinc_reducer1.py \
    -input input/data.csv -output output/all_accidents.  
    Only works in Hortonworks HDP sandbox when it's a single line.  
  * No instructions on how to run bash script in Hadoop.   
    hadoop fs -cat /test_data/map_reduce_job.sh|exec sh  
* Map/Reduce job fails in Hadoop sandbox.  
  Tried 2 different map/reduce jobs, including this one https://www.michael-noll.com/tutorials/writing-an-hadoop-mapreduce-program-in-python/.  
  21/02/28 03:45:06 INFO mapreduce.Job: Task Id : attempt_1614468322214_0009_m_000001_0, Status : FAILED                                                            
  
  **Error**: java.lang.RuntimeException: PipeMapRed.waitOutputThreads(): subprocess failed with code 127                                                                
        at org.apache.hadoop.streaming.PipeMapRed.waitOutputThreads(PipeMapRed.java:322)                                                                          
        at org.apache.hadoop.streaming.PipeMapRed.mapRedFinished(PipeMapRed.java:535)                                                                             
        at org.apache.hadoop.streaming.PipeMapper.close(PipeMapper.java:130)                                                                                      
        at org.apache.hadoop.mapred.MapRunner.run(MapRunner.java:61)                                                                                              
        at org.apache.hadoop.streaming.PipeMapRunner.run(PipeMapRunner.java:34)                                                                                   
        at org.apache.hadoop.mapred.MapTask.runOldMapper(MapTask.java:453)                                                                                        
        at org.apache.hadoop.mapred.MapTask.run(MapTask.java:343)                                                                                                 
        at org.apache.hadoop.mapred.YarnChild$2.run(YarnChild.java:168)                                                                                           
        at java.security.AccessController.doPrivileged(Native Method)                                                                                             
        at javax.security.auth.Subject.doAs(Subject.java:422)                                                                                                     
        at org.apache.hadoop.security.UserGroupInformation.doAs(UserGroupInformation.java:1724)                                                                   
        at org.apache.hadoop.mapred.YarnChild.main(YarnChild.java:162)       

  Tried these suggestions but nothing worked:  
  https://stackoverflow.com/questions/43048654/hadoop-python-subprocess-failed-with-code-127