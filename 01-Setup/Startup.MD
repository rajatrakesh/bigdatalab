### VM Setup

#### Instructions


* Uncompress the zip file and import the VM into VMware/Virtualbox. For this workshop, I recommend Virtualbox. 
* Your laptop must have ATLEAST 16 GB RAM for this workshop. If not, you would NOT be able to proceed and complete multiple labs, setups etc. 
* Assign 12072 (min) as memory to the VM image and 2 virtual processors. Boot up the VM. 
* Ensure DVD Option is enabled
* Install Guest Editions after bootup
* Click the Cloudera Enterprise (Trial) Option on Desktop
* After successful setup, REBOOT !

After restart, click the Cloduera Manager option in Firefox and wait for Cloudera Manager to start up. Sometimes, this can take more than 15 mins. 

#### Issues

After startup, you may see multiple issues in Cloudera Manager. Let's try and address the most important ones as follows:
* Host Monitor - Need to start
* Services Monitor - Need to start
* Management Console - Need to re-start
* There would be a lot of configuration related warnings that would be displayed. This is NORMAL, since the Virtual machine has only one node. Suppress all warnings being displayed. 

#### Startup

Start the services in the following order:

* Zookeeper
* YARN
* HDFS
* Hive
* Impala
* HBase
* Oozie
* Hue

This is the bare minimum of services that would be required in the first lab. There would be further installations and configurations that would be required in the labs that will follow. 
