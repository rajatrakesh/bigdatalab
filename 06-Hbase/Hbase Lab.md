## Hbase Lab

In this lab, we will have a hand-on experience with a column based store : HBase.  HBase is essentially a faithful reproduction of Google’s BigTable
and tends towards write consistency, (loosely speaking, CP in the CAP theorem). HBase was originally designed to be tightly coupled with HDFS/Hadoop, meaning that one could read/write to/from HBase tables (stored on HDFS) using Hadoop. For example one can analyse a huge HBase table with Hadoop, or join tables, or transform one table to another. Though we won’t go into detail on this quite now, I’ll link to further material for reading at the end. 

Now let's get started with the hbase lab. 

#### Start the Hbase Shell

		[cloudera@quickstart ~]$ hbase shell
		18/10/15 08:53:38 INFO Configuration.deprecation: hadoop.native.lib is deprecated. Instead, use io.native.lib.available
		HBase Shell; enter 'help<RETURN>' for list of supported commands.
		Type "exit<RETURN>" to leave the HBase Shell
		Version 1.2.0-cdh5.13.0, rUnknown, Wed Oct  4 11:16:18 PDT 2017
		
		hbase(main):001:0>
		
#### Housekeeping Commands
You can configure users and user privileges for interacting with different namespaces/tables.

	hbase(main):001:0> whoami
	cloudera (auth:SIMPLE)
	    groups: cloudera, default
    
Status of various services

	hbase(main):009:0> status 'simple'
	
	hbase(main):003:0> status 'simple'
	active master:  quickstart.cloudera:60000 1539620289244
	0 backup masters
	1 live servers
	    quickstart.cloudera:60020 1539620289313
	        requestsPerSecond=0.0, numberOfOnlineRegions=2, usedHeapMB=32, maxHeapMB=48, numberOfStores=2, numberOfStorefiles=3, storefileUncompressedSizeMB=0, storefileSizeMB=0, memstoreSizeMB=0, storefileIndexSizeMB=0, readRequestsCount=10, writeRequestsCount=1, rootIndexSizeKB=0, totalStaticIndexSizeKB=0, totalStaticBloomSizeKB=0, totalCompactingKVs=0, currentCompactedKVs=0, compactionProgressPct=NaN, coprocessors=[MultiRowMutationEndpoint, RegionAuditCoProcessor, SecureBulkLoadEndpoint]
	0 dead servers
	Aggregate load: 0, regions: 2
  
#### Create/Alter/Remove Tablespace
Let’s create a namespace and list the namespaces available.

	hbase(main):004:0> create_namespace 'cloudera'
	0 row(s) in 0.1240 seconds
	
	hbase(main):005:0> list_namespace
	NAMESPACE                                                                      
	cloudera                                                                       
	default                                                                        
	hbase                                                                          
	3 row(s) in 0.0290 seconds

Namespaces are associated with some options. Likewise user privileges can be set at the namespacelevel. Let’s see what options are set right now and change a setting to say the namespace can contain a maximum of one table:

* describe_namespace 'cloudera'
* alter_namespace 'cloudera', {METHOD => 'set', 'hbase.namespace.quota.maxtables'=>'1'}
* describe_namespace 'cloudera'

		hbase(main):006:0> describe_namespace 'cloudera'
		DESCRIPTION                                                                    
		{NAME => 'cloudera'}                                                           
		1 row(s) in 0.0160 seconds

		hbase(main):007:0> alter_namespace 'cloudera', {METHOD => 'set', 'hbase.namespace.quota.maxtables'=>'1'}
		0 row(s) in 0.0920 seconds

		hbase(main):008:0> describe_namespace 'cloudera'
		DESCRIPTION                                                                    
		{NAME => 'cloudera', hbase.namespace.quota.maxtables => '1'}                   
		1 row(s) in 0.0080 seconds

#### Creating Tables

Let’s create a table under that namespace:

`create 'cloudera:firsttable'`
This command will NOT work, because the statement needs at least one column family (a group of related columns). 

Here we create a
table with two column families called (imaginatively) f1 and f2:

`create 'cloudera:firsttable', 'f1', 'f2'`

	hbase(main):009:0> create 'cloudera:firsttable','f1','f2'
	0 row(s) in 1.9600 seconds
	
	=> Hbase::Table - cloudera:firsttable

We can set options on a column family level. Above we just set some defaults; let’s see:

`describe 'cloudera:firsttable'`

	hbase(main):010:0> describe 'cloudera:firsttable'
		Table cloudera:firsttable is ENABLED                                           
		cloudera:firsttable                                                            
		COLUMN FAMILIES DESCRIPTION                                                    
		{NAME => 'f1', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
		_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL
		 => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =
		> 'false', BLOCKCACHE => 'true'}                                               
		{NAME => 'f2', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
		_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL
		 => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =
		> 'false', BLOCKCACHE => 'true'}                                               
		2 row(s) in 0.1190 seconds

Okay, let’s change the table to keep the last three versions of values in the f1 column family, a time-to-live of 36000 on the second column family, and to add a third (new) column family:

`alter 'cloudera:firsttable', {NAME => 'f1', VERSIONS => 5}, {NAME => 'f2', TTL => 36000},'f3'`

	hbase(main):011:0> alter 'cloudera:firsttable', {NAME => 'f1', VERSIONS => 5}, {NAME => 'f2', TTL => 36000},
		hbase(main):012:0* 'f3'
		Updating all regions with the new schema...
		1/1 regions updated.
		Done.
		Updating all regions with the new schema...
		1/1 regions updated.
		Done.
		Updating all regions with the new schema...
		1/1 regions updated.
		Done.
		0 row(s) in 5.8550 seconds

`describe 'cloudera:firsttable'`

	hbase(main):013:0> describe 'cloudera:firsttable'
		Table cloudera:firsttable is ENABLED                                           
		cloudera:firsttable                                                            
		COLUMN FAMILIES DESCRIPTION                                                    
		{NAME => 'f1', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
		_SCOPE => '0', VERSIONS => '5', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL
		 => 'FOREVER', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =
		> 'false', BLOCKCACHE => 'true'}                                               
		{NAME => 'f2', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
		_SCOPE => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL
		 => '36000 SECONDS (10 HOURS)', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65
		536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}                              
		{NAME => 'f3', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
		_SCOPE => '0', COMPRESSION => 'NONE', VERSIONS => '1', TTL => 'FOREVER', MIN_VE
		RSIONS => '0', KEEP_DELETED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY =
		> 'false', BLOCKCACHE => 'true'}                                               
		3 row(s) in 0.0380 seconds

If we want, we can create the table with these settings directly. Let’s try create a second table:

`create 'cloudera:secondtable', {NAME => 'f1', VERSIONS => 5, TTL => 1000, COMPRESSION=> 'GZ'}`

	hbase(main):017:0> create 'cloudera:secondtable', {NAME => 'f1', VERSIONS => 5, TTL => 1000, COMPRESSION=> 'GZ'}
		0 row(s) in 2.2590 seconds
		
		=> Hbase::Table - cloudera:secondtable		
`describe 'cloudera:secondtable'`

	hbase(main):018:0> describe 'cloudera:secondtable'
			Table cloudera:secondtable is ENABLED                                          
			cloudera:secondtable                                                           
			COLUMN FAMILIES DESCRIPTION                                                    
			{NAME => 'f1', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION
			_SCOPE => '0', VERSIONS => '5', COMPRESSION => 'GZ', MIN_VERSIONS => '0', TTL =
			> '1000 SECONDS (16 MINUTES 40 SECONDS)', KEEP_DELETED_CELLS => 'FALSE', BLOCKS
			IZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}                    
			1 row(s) in 0.0300 seconds
	

#### Removing tables and namespace
Okay, so let’s remove the tables and the namespace you just created:

* First let’s list all tables: 

`list`

		hbase(main):020:0* list
			TABLE                                                                          
			cloudera:firsttable                                                            
			cloudera:secondtable                                                           
			2 row(s) in 0.0180 seconds
	
* Let’s try drop that pesky second table that should not exist:

`drop 'cloudera:secondtable'`

	hbase(main):021:0> drop 'cloudera:secondtable'
	
	ERROR: Table cloudera:secondtable is enabled. Disable it first.
	
	Drop the named table. Table must first be disabled:
	  hbase> drop 't1'
	  hbase> drop 'ns1:t1'
	  
Hmm ... didn’t work. Before we remove a table, we have to disable reads to it first:

`disable 'cloudera:secondtable'`
`drop 'cloudera:secondtable'`

	hbase(main):022:0> disable 'cloudera:secondtable'
		0 row(s) in 2.3100 seconds
		
		hbase(main):023:0> drop 'cloudera:secondtable'
		0 row(s) in 1.2860 seconds
		
Success.

* Now let’s try drop the namespace:

`drop_namespace 'cloudera'`
			
		hbase(main):024:0> drop_namespace 'cloudera'
		
		ERROR: org.apache.hadoop.hbase.constraint.ConstraintException: Only empty namespaces can be removed. Namespace cloudera has 1 tables
			at org.apache.hadoop.hbase.master.TableNamespaceManager.remove(TableNamespaceManager.java:200)
			at org.apache.hadoop.hbase.master.HMaster.deleteNamespace(HMaster.java:2571)
			at org.apache.hadoop.hbase.master.MasterRpcServices.deleteNamespace(MasterRpcServices.java:496)
			at org.apache.hadoop.hbase.protobuf.generated.MasterProtos$MasterService$2.callBlockingMethod(MasterProtos.java:55730)
			at org.apache.hadoop.hbase.ipc.RpcServer.call(RpcServer.java:2191)
			at org.apache.hadoop.hbase.ipc.CallRunner.run(CallRunner.java:112)
			at org.apache.hadoop.hbase.ipc.RpcExecutor$Handler.run(RpcExecutor.java:183)
			at org.apache.hadoop.hbase.ipc.RpcExecutor$Handler.run(RpcExecutor.java:163)
		
		Drop the named namespace. The namespace must be empty.

Doesn’t work. You can’t drop a namespace while there’s a table in it. Drop the remaining table and then drop the namespace.

	hbase(main):028:0> disable 'cloudera:firsttable'
	0 row(s) in 0.0550 seconds
	
	hbase(main):029:0> drop 'cloudera:firsttable'
	0 row(s) in 1.2700 seconds
	
	hbase(main):030:0> drop_namespace 'cloudera'
	0 row(s) in 0.0330 seconds
	



