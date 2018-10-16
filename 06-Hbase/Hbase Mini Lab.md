## HBase Mini Lab

#### Create Namespace

	hbase(main):001:0> create_namespace 'cloudera1'
	0 row(s) in 0.2980 seconds

#### Create table

	hbase(main):002:0> create 'cloudera1:table_1','column_family1','column_family2','column_family3'
	0 row(s) in 1.5610 seconds
	
#### Describe table

	hbase(main):033:0> describe 'cloudera1:table_1'
	Table cloudera1:table_1 is ENABLED                                                               
	cloudera1:table_1                                                                                
	COLUMN FAMILIES DESCRIPTION                                                                      
	{NAME => 'column_family1', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE
	 => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELE
	TED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'true', BLOCKCACHE => 'true'}           
	{NAME => 'column_family2', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE
	 => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELE
	TED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}          
	{NAME => 'column_family3', DATA_BLOCK_ENCODING => 'NONE', BLOOMFILTER => 'ROW', REPLICATION_SCOPE
	 => '0', VERSIONS => '1', COMPRESSION => 'NONE', MIN_VERSIONS => '0', TTL => 'FOREVER', KEEP_DELE
	TED_CELLS => 'FALSE', BLOCKSIZE => '65536', IN_MEMORY => 'false', BLOCKCACHE => 'true'}          
	3 row(s) in 0.0670 seconds

	
#### Enable multiple versions for a particular column family

	hbase(main):019:0> alter 'cloudera1:table_1', {NAME => 'column_family1', VERSIONS => 1}
	Updating all regions with the new schema...
	0/1 regions updated.
	1/1 regions updated.
	Done.
	0 row(s) in 3.0200 seconds

#### Alter table to store a particular column in memory

	hbase(main):020:0> alter 'cloudera1:table_1', {NAME => 'column_family1', IN_MEMORY => 'true'}
	Updating all regions with the new schema...
	1/1 regions updated.
	Done.
	0 row(s) in 1.9590 seconds

#### Load data in the table

	hbase(main):008:0> put 'cloudera1:table_1','row1','column_family1:c11','r1v11'
	0 row(s) in 0.0730 seconds
	
	hbase(main):009:0> put 'cloudera1:table_1','row1','column_family1:c12','r1v12'
	0 row(s) in 0.0120 seconds
	
	hbase(main):010:0> put 'cloudera1:table_1','row1','column_family2:c21','r1v21'
	0 row(s) in 0.0110 seconds
	
	hbase(main):011:0> put 'cloudera1:table_1','row1','column_family3:c31','r1v31'
	0 row(s) in 0.0060 seconds
	
	hbase(main):012:0> put 'cloudera1:table_1','row2','column_family1:d11','r2v11'
	0 row(s) in 0.0110 seconds
	
	hbase(main):013:0> put 'cloudera1:table_1','row2','column_family1:d12','r2v12'
	0 row(s) in 0.0060 seconds
	
	hbase(main):014:0> put 'cloudera1:table_1','row2','column_family2:d21','r2v21'
	0 row(s) in 0.0060 seconds

#### Count the number of records in the table

	hbase(main):015:0> count 'cloudera1:table_1'
	2 row(s) in 0.0740 seconds
	
	=> 2

#### Show the data in Row 1

	hbase(main):017:0> get 'cloudera1:table_1','row1'
	COLUMN                CELL                                                      
	 column_family1:c11   timestamp=1539664051648, value=r1v11                      
	 column_family1:c12   timestamp=1539664065745, value=r1v12                      
	 column_family2:c21   timestamp=1539664083385, value=r1v21                      
	 column_family3:c31   timestamp=1539664103374, value=r1v31                      
	4 row(s) in 0.0160 seconds

#### Scan Full Table

	hbase(main):018:0> scan 'cloudera1:table_1'
	ROW                   COLUMN+CELL                                               
	 row1                 column=column_family1:c11, timestamp=1539664051648, value=
	                      r1v11                                                     
	 row1                 column=column_family1:c12, timestamp=1539664065745, value=
	                      r1v12                                                     
	 row1                 column=column_family2:c21, timestamp=1539664083385, value=
	                      r1v21                                                     
	 row1                 column=column_family3:c31, timestamp=1539664103374, value=
	                      r1v31                                                     
	 row2                 column=column_family1:d11, timestamp=1539664129097, value=
	                      r2v11                                                     
	 row2                 column=column_family1:d12, timestamp=1539664144775, value=
	                      r2v12                                                     
	 row2                 column=column_family2:d21, timestamp=1539664160312, value=
	                      r2v21                                                     
	2 row(s) in 0.0540 seconds

#### Update data values

	hbase(main):021:0> put 'cloudera1:table_1','row1','column_family1:c11','n1v11'
	0 row(s) in 0.0260 seconds
	
	hbase(main):022:0> put 'cloudera1:table_1','row2','column_family1:d11','n2v11'
	0 row(s) in 0.0120 seconds
	
	hbase(main):023:0> put 'cloudera1:table_1','row2','column_family2:d21','n2v21'
	0 row(s) in 0.0120 seconds

#### Scan the full table

	hbase(main):024:0> scan 'cloudera1:table_1'
	ROW                   COLUMN+CELL                                               
	 row1                 column=column_family1:c11, timestamp=1539664392039, value=
	                      n1v11                                                     
	 row1                 column=column_family1:c12, timestamp=1539664065745, value=
	                      r1v12                                                     
	 row1                 column=column_family2:c21, timestamp=1539664083385, value=
	                      r1v21                                                     
	 row1                 column=column_family3:c31, timestamp=1539664103374, value=
	                      r1v31                                                     
	 row2                 column=column_family1:d11, timestamp=1539664406857, value=
	                      n2v11                                                     
	 row2                 column=column_family1:d12, timestamp=1539664144775, value=
	                      r2v12                                                     
	 row2                 column=column_family2:d21, timestamp=1539664423263, value=
	                      n2v21                                                     
	2 row(s) in 0.0330 seconds

#### Access data for a specific row and column

	hbase(main):026:0> get 'cloudera1:table_1','row2','column_family2:d21'
	COLUMN                    CELL                                                                   
	 column_family2:d21       timestamp=1539664423263, value=n2v21                                   
	1 row(s) in 0.0330 seconds

#### Query data from all rows that begin with 'row'

	hbase(main):032:0> scan 'cloudera1:table_1', STARTROW => 'row'
	ROW                       COLUMN+CELL                                                            
	 row1                     column=column_family1:c11, timestamp=1539664392039, value=n1v11        
	 row1                     column=column_family1:c12, timestamp=1539664065745, value=r1v12        
	 row1                     column=column_family2:c21, timestamp=1539664083385, value=r1v21        
	 row1                     column=column_family3:c31, timestamp=1539664103374, value=r1v31        
	 row2                     column=column_family1:d11, timestamp=1539664406857, value=n2v11        
	 row2                     column=column_family1:d12, timestamp=1539664144775, value=r2v12        
	 row2                     column=column_family2:d21, timestamp=1539664423263, value=n2v21        
	2 row(s) in 0.0220 seconds

