CREATE EXTERNAL TABLE default.twitteravro
ROW FORMAT SERDE
'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS INPUTFORMAT
'org.apache.hadoop.hive.ql.io.avro.AvroContainer
InputFormat'
OUTPUTFORMAT
'org.apache.hadoop.hive.ql.io.avro.AvroContainer
OutputFormat'
TBLPROPERTIES
('avro.schema.url'='/user/cloudera/bigdatalab/config/hive/twitter_avro_schema.avsc);