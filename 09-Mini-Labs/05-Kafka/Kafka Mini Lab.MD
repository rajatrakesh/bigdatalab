#### Running the Kafka Connect
* Copy the config files to the /config folder
	` sudo cp /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/connect-standalone.properties /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/lib/kafka/config`
	` sudo cp /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/connect-file-source.properties /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/lib/kafka/config`
	` sudo cp /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/connect-file-sink.properties /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/lib/kafka/config`
	` sudo cp /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/server.properties /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/lib/kafka/config`
	` sudo cp /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/connect-log4j.properties /opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/lib/kafka/config`
	
* For easy reference, I downloaded the first 4 in the quickstart.cloudera home folder and edited them there. 

* If you get AddressInUse exceptions, then add a line `rest.port=18083` in your `connect-standalone.properties` file. Also change references of `localhost` to `quickstart.cloudera` where ever applicable
* Sample log files are available in the config folder
* Create a sample test file
	
* Modify the required config files

* Execute the command:
`connect-standalone.sh connect-standalone.properties connect-file-source.properties connect-file-sink.properties`

* Contents of text.txt  
`[cloudera@quickstart ~]$ cat test.txt`  
`foo`  
`bar`

* After successful exection: 

![Kafka Consumer](../../images/kafka/kafka9.jpg)

**TIP** A sample for these files would be available in `/opt/cloudera/parcels/KAFKA-3.1.0-1.3.1.0.p0.35/etc/kafka/conf.dist/`
