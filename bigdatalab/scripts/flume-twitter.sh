#!/bin/bash


echo "Starting the deployment"
echo "Copying Flume Jars...."
sudo cp bigdatalab/config/flume/jar/* /usr/lib/flume-ng/lib/
export CLASSPATH=$CLASSPATH:/usr/lib/flume-ng/lib/
echo "Create HDFS Directory to store twitter data..."
hdfs dfs -mkdir /user/cloudera/twitter_data
echo "Starting the Flume Agent..."
flume-ng agent -f /bigdatalab/config/flume/conf/twitter.conf -Dflume.root.logger=INFO,console -n TwitterAgent &
echo "Check that the tweets are being written..."
hdfs dfs -ls /user/cloudera/twitter_data/
