### Mini-Lab:

* Create a namespace 'cloudera1'
* Create a table 'table_1' with 3 column families (column_family1,column_family2,column_family3)
* Describe the table structure
* Enable tracking the option for multiple versions in 'column_family1' (5 Versions)
* Alter table to store 'column_family1' in memory
* Load the following data in the table
- row1,colum_family1:c11 value:r1v11
- row1,colum_family1:c12 value:r1v12
- row1,colum_family2:c21 value:r1v21
- row1,colum_family3:c31 value r1v31
- row2,colum_family1:d11 value r2v11
- row2,colum_family1:d12 value r2v12
- row2,colum_family2:d21 value r2v21
* Count the number of records
* Display the full data from 'row1'
* Scan the full table
* Update the values as follows:
- row1,ccolum_family1:c11 value n1v11
- row2,colum_family1:d11 value n2v11
- row2,colum_family2:d21 value n2v21
* Scan the full table again to track changes
* Access data for 'row2','column_family2'
* Display values for all rows that begin with 'row'