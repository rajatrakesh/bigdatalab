### Hive Mini Assigment

* In this hive mini-assignment, you would need to do the following:

* create a folder in HDFS 
	- ```/user/cloudera/mediademo```
	- ```/user/cloudera/mediademo/media_movielog```
	- ```/user/cloudera/mediademo/media_customer ```

* Put the media_customer.txt in the folder ```/user/cloudera/mediademo/media_customer```

* Create a parquet table with location
	- Modify the ```media_customer.dll``` to create a parquet table which uses the data loaded in the ```/user/cloudera/mediademo/media_customer``` location


* Create a hive table ```media_activity``` with this structure
	- ```cust_id``` (int)
	- ```in_market``` (string)
	- ```predictors``` (string)
	- ```demographics``` (string)
This table would be row delimited and columns seperated by tab. This table should be stored as Parquet.

* Load data in this table from the text file ```media_activity.txt```




	
