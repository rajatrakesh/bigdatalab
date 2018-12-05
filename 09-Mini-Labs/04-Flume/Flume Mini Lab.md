### Flume Mini Lab

#### Read a twitter stream and land that data into HDFS

* Create an application in Twitter with your twitter account

[https://apps.twitter.com](https://apps.twitter.com)

**NOTE** As of July 2018, Twitter has _slightly_ more complicated process to give permission to build apps. You will need to register and fill in a form (takes less than 10 minutes), which will then give you the required access to build apps. 

* Once you have access to Twitter, you would be able to register an app there

![Twitter Apps](../images/flume/flume_twitter1.jpg)

* Once you build you app, what you really need is your credentials, so that you can access Twitter Data

![Twitter Apps](../images/flume/flume_twitter2.jpg)

* Note these credentials, as you would be needing these in the conf file for Flume

* Download the following jar files (Twitter)

		* twitter4j-async-4.0.4.jar
		* twitter4j-core-4.0.4.jar
		* twitter4j-media-support-4.0.4.jar
		* twitter4j-stream-4.0.4.jar

**HINT** These files have been made available in the `/flume/mini-lab/config` folder.

* Copy these files to the `/usr/lib/flume-ng/lib/` folder.

* Start a terminal window and setup the following classpath (for this session)
	
	export CLASSPATH=$CLASSPATH:/usr/lib/flume-ng/lib/

* Create an director in HDFS to capture the twitter data

	hdfs dfs -mkdir /user/cloudera/twitter_data
	
* Create a conf file for the agent

		TwitterAgent.sources = Twitter
		TwitterAgent.channels = MemChannel
		TwitterAgent.sinks = HDFS
	
		# Describing/Configuring the source
		TwitterAgent.sources.Twitter.type = org.apache.flume.source.twitter.TwitterSource
		TwitterAgent.sources.Twitter.consumerKey = **********************
		TwitterAgent.sources.Twitter.consumerSecret = ********************************************
		TwitterAgent.sources.Twitter.accessToken = **********-**********************
		TwitterAgent.sources.Twitter.accessTokenSecret = ********************************************
		
		TwitterAgent.sinks.HDFS.type = hdfs
		TwitterAgent.sinks.HDFS.hdfs.path = /user/cloudera/twitter_data/
		TwitterAgent.sinks.HDFS.hdfs.fileType = DataStream
		TwitterAgent.sinks.HDFS.hdfs.writeFormat = Text
		TwitterAgent.sinks.HDFS.hdfs.batchSize = 5
		TwitterAgent.sinks.HDFS.hdfs.rollSize = 0
		TwitterAgent.sinks.HDFS.hdfs.rollCount = 10
		
		# Describing/Configuring the channel
		
		TwitterAgent.channels.MemChannel.type = memory
		TwitterAgent.channels.MemChannel.capacity = 10000
		TwitterAgent.channels.MemChannel.transactionCapacity = 100
		
		# Binding the source and sink to the channel
		TwitterAgent.sources.Twitter.channels = MemChannel
		TwitterAgent.sinks.HDFS.channel = MemChannel
		
* Start the flume agent

		flume-ng agent -f twitter.conf -Dflume.root.logger=INFO,console -n TwitterAgent

![Twitter Agent](../images/flume/flume_twitter3.jpg)

* Check the HDFS directory to see that messages are being written

![Twitter Agent](../images/flume/flume_twitter4.jpg)

* To see what is actually being written in

		hdfs dfs -ls /user/cloudera/twitter_data/
		hdfs dfs -cat /user/cloudera/twitter_data/FlumeData.1536137681761
		
![Twitter Agent](../images/flume/flume_twitter5.jpg)






