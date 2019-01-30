## Hive Mini-Assignment

### Create the requried folders and copy over files

	hdfs dfs -mkdir /user/cloudera/mediademo/media_activity
	hdfs dfs -mkdir /user/cloudera/mediademo/media_movielog
	hdfs dfs -mkdir /user/cloudera/mediademo/media_customer
	hdfs dfs -copyFromLocal media_customer.txt /user/cloudera/mediademo/media_customer/
	hdfs dfs -mkdir /user/cloudera/mediademo/media_activity
	hdfs dfs -copyFromLocal media_activity.txt /user/cloudera/mediademo/media_activity/

### Table media_activity

	create table media_activity_temp (cust_id int, in_market string, predictors string, demographics string)
	ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
	stored as textfile;
	
	LOAD DATA INPATH '/user/cloudera/mediademo/media_activity/media_activity.txt' OVERWRITE INTO TABLE media_activity_temp;
	
	create table media_activity (cust_id int, in_market string, predictors string, demographics string)
	ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
	stored as parquet;
	
	insert overwrite table media_activity select * from media_activity_temp;

### Table media_customer

	CREATE EXTERNAL TABLE media_customer_temp (
	cust_id int,last_name string,first_name string,
	street_address string,postal_code string,city_id int,
	city string,state_province_id int,state_province string,
	country_id int,country string,continent_id int,continent string,
	age int,commute_distance int,credit_balance int,education string,
	email string,full_time string,gender string,household_size int,
	income int,income_level string,insuff_funds_incidents int,
	job_type string,late_mort_rent_pmts int,marital_status string,
	mortgage_amt int,num_cars int,num_mortgages int,pet string,
	promotion_response int,rent_own string,seg int,work_experience int,
	yrs_current_employer int,yrs_customer int,yrs_residence int,
	country_code string,username string,customer_address string,
	customer_geo_geo string
	) 
	row format delimited fields terminated by '\t'
	location '/user/cloudera/mediademo/media_customer/';
	
	CREATE TABLE media_customer
	stored as parquet
	as select * from media_customer_temp;