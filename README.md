## Cloudera Big Data Lab

#### Pre-requisites:
* Cloudera Quick Start VM (Kudu Not installed)
* Working Internet Connection
* Oracle VM Virtualbox (preferred) or Vmware
* Basic working knowledge of CDH and SQL
* Laptop with minimum 16 GB RAM

### Labs Agenda

* Pre-requisites and Setup
	- Validate Cloudera Manager
	- Configure the VM
* Installation
	- Kafka
	- Kudu
	- Python (Tweepy, Kafka-python)
* Hands-On Labs
 * HDFS & Hive
 * Flume 
 * Kafka 
 * Impala
 * Hbase
 * Kudu
 * Assignment / Use Case
 
### Pre-Setup for Lab

While it is preferred that there is a good internet connection available to all participants during the course of the lab, as there would be downloads required for installing various packages. If the same is not available, there is an option for pre-downloading certain packages before starting with the labs. The following steps would be required:

* Start the VM image (No other services need to be started for this exercise)
* Make sure that the VM image is able to access internet from the VM itself using the browser. We would be downloading approximately 1 GB of data
* Open a terminal window and type the following

		cd /etc/yum.repos.d
		sudo yum install kafka kafka-server --downloadonly
		sudo wget archive.cloudera.com/kudu/redhat/6/x86_64/kudu/cloudera-kudu.repo
		sudo yum install kudu kudu-master kudu-tserver --downloadonly
		sudo yum install telnet-server telnet --downloadonly
		sudo yum install python-pip --downloadonly
		
OR 

* You can leverage an AMI image made available on AWS, which is a clone of the Cloudera QuickStart 5.13 VM. Please note that this may involve charges on AWS for running this instance for the duration of the workshop. 

Instructions for the AWS Setup are available [here](https://github.com/rajatrakesh/bigdatalab/blob/master/01-Setup/AWS%20Setup.MD)

### Watch the Cloudera Essential Video (2 Hours)
As a pre-requisite, all participants must watch the 'Cloudera Essentials for Apache Hadoop' video below, before coming to the session:

https://ondemand.cloudera.com/courses/course-v1:Cloudera+ESS+0/about



