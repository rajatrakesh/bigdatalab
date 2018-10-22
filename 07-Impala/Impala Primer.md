## Impala Lab

This lab demonstrates the basics of using Impala. During the workshop, we will use Impala for querying tables created in Hive, Kudu and Hbase. 

#### Start Impala Shell

The easiest option to access Impala is from Hue. However, for the course of this lab, we will connect to Impala directly using the shell.

$ impala-shell -i localhost --quiet

For the purpose of this lab, we will setup some sample tables provided in examples and we will create a few additional ones as well. 

A completely empty impala instance contains no tables, but still has two databases:
* default - where all tables are created if no database is specified. (All sample tables loaded through hue would be here)
* _impala_builtins - system databases used to hold all built in functions

	[cloudera@quickstart ~]$ impala-shell -i quickstart.cloudera --quiet
	Starting Impala Shell without Kerberos authentication
	***********************************************************************************
	Welcome to the Impala shell.
	(Impala Shell v2.10.0-cdh5.13.0 (2511805) built on Wed Oct  4 10:55:37 PDT 2017)
	
	To see live updates on a query's progress, run 'set LIVE_SUMMARY=1;'.
	***********************************************************************************
	
* Show the Imapla Version

		[quickstart.cloudera:21000] > select version();
		+-------------------------------------------------------------------------------------------+
		| version()                                                                                 |
		+-------------------------------------------------------------------------------------------+
		| impalad version 2.10.0-cdh5.13.0 RELEASE (build 2511805f1eaa991df1460276c7e9f19d819cd4e4) |
		| Built on Wed Oct  4 10:55:37 PDT 2017                                                     |
		+-------------------------------------------------------------------------------------------+
		
* Show Databases

		[quickstart.cloudera:21000] > show databases;
		+------------------+----------------------------------------------+
		| name             | comment                                      |
		+------------------+----------------------------------------------+
		| _impala_builtins | System database for Impala builtin functions |
		| default          | Default Hive database                        |
		+------------------+----------------------------------------------+
		
* Show Current Database

		[quickstart.cloudera:21000] > select current_database();
		+--------------------+
		| current_database() |
		+--------------------+
		| default            |
		+--------------------+

* List Tables in Current Database	
	
		[quickstart.cloudera:21000] > show tables;
		+-------------+
		| name        |
		+-------------+
		| categories  |
		| customers   |
		| departments |
		| order_items |
		| sample_07   |
		| sample_08   |
		| web_logs    |
		+-------------+
		
* Filter the list of tables
		
		[quickstart.cloudera:21000] > show tables in default like 'cust*';
		+-----------+
		| name      |
		+-----------+
		| customers |
		+-----------+
* Use the default database and do some basic queries
		
		[quickstart.cloudera:21000] > use default;
		[quickstart.cloudera:21000] > describe categories;
		+------------------------+--------+---------+
		| name                   | type   | comment |
		+------------------------+--------+---------+
		| category_id            | int    |         |
		| category_department_id | int    |         |
		| category_name          | string |         |
		+------------------------+--------+---------+
		[quickstart.cloudera:21000] > select count(*) from categories;
		+----------+
		| count(*) |
		+----------+
		| 116      |
		+----------+
		[quickstart.cloudera:21000] > describe customers;
		+-------------------+--------+---------+
		| name              | type   | comment |
		+-------------------+--------+---------+
		| customer_id       | int    |         |
		| customer_fname    | string |         |
		| customer_lname    | string |         |
		| customer_email    | string |         |
		| customer_password | string |         |
		| customer_street   | string |         |
		| customer_city     | string |         |
		| customer_state    | string |         |
		| customer_zipcode  | string |         |
		+-------------------+--------+---------+
		[quickstart.cloudera:21000] > select count(distinct customer_city) from customers;
		+-------------------------------+
		| count(distinct customer_city) |
		+-------------------------------+
		| 562                           |
		+-------------------------------+
		[quickstart.cloudera:21000] > select distinct customer_city from customers limit 10;
		+---------------+
		| customer_city |
		+---------------+
		| Folsom        |
		| Lenoir        |
		| Milpitas      |
		| Gwynn Oak     |
		| Endicott      |
		| Panorama City |
		| Morganton     |
		| Carson        |
		| Richardson    |
		| Zanesville    |
		+---------------+
		
* Create Database

		[quickstart.cloudera:21000] > create database bigdatalab;
		[quickstart.cloudera:21000] > show databases;
		+------------------+----------------------------------------------+
		| name             | comment                                      |
		+------------------+----------------------------------------------+
		| _impala_builtins | System database for Impala builtin functions |
		| bigdatalab       |                                              |
		| default          | Default Hive database                        |
		+------------------+----------------------------------------------+

* Create Table

		[quickstart.cloudera:21000] > create table t1 (x int);
		[quickstart.cloudera:21000] > show tables;
		+-------------+
		| name        |
		+-------------+
		| categories  |
		| customers   |
		| departments |
		| order_items |
		| sample_07   |
		| sample_08   |
		| t1          |
		| web_logs    |
		+-------------+
		
Note: Can you spot the problem ?
The table has been created in the wrong database since it was the one selected. This is a common mistake while creating tables in Impala. We will now use alter table to move it in the right place. 

	[quickstart.cloudera:21000] > select current_database();
	+--------------------+
	| current_database() |
	+--------------------+
	| default            |
	+--------------------+
	[quickstart.cloudera:21000] > alter table t1 rename to bigdatalab.t1;
	[quickstart.cloudera:21000] > use bigdatalab;
	[quickstart.cloudera:21000] > show tables;
	+------+
	| name |
	+------+
	| t1   |
	+------+
	[quickstart.cloudera:21000] > select current_database();
	+--------------------+
	| current_database() |
	+--------------------+
	| bigdatalab         |
	+--------------------+
	
* Inserting values in the table

