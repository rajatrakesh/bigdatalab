## Cloudera Big Data Lab

#### Pre-requisites:
* Cloudera Quick Start VM (Kudu Not installed)
* Working Internet Connection
* Oracle VM Virtualbox
* Basic working knowledge of CDH and SQL
* Laptop with minimum 16 GB RAM

### Labs Agenda

 * Pre-requisites and Setup
	- Validate Cloudera Manager
 	- Kudu Installation
 	- Kafka Installation
 * HDFS Hands-On
 * Hive Hands-On
 * Flume Hands-On
 * Kafka Lab
 * Impala Hands-On
 * Hbase Hands-On
 * Kudu Hands-On
 * Assignment / Use Case
 * Q & A
 
 
### Pre-Setup for Lab

While it is preferred that there is a good internet connection available to all participants during the course of the lab, as there would be downloads required for installing various packages. If the same is not available, there is an option for pre-downloading certain packages before starting with the labs. The following steps would be required:

* Start the VM image (No other services need to be started for this exercise)
* Make sure that the VM image is able to access internet from the VM itself. We would be downloading approximately 1 GB of data
* Open a terminal window and type the following

cd /etc/yum.repos.d
sudo yum install kafka kafka-server --downloadonly
sudo wget archive.cloudera.com/kudu/redhat/6/x86_64/kudu/cloudera-kudu.repo
sudo yum install kudu kudu-master kudu-tserver --downloadonly
sudo yum install telnet-server telnet --downloadonly
sudo yum install python-pip --downloadonly

### Download Sample Datasets
cd 
wget http://kudu-sample-data.s3.amazonaws.com/sfmtaAVLRawData01012013.csv.gz
wget **placeholder for all datasets**


