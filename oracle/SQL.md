# SQL (STRUCTURE QUERY LANGUAGE)
* SQL is an Non- procedural language, which is used to operate all relational database 
products.
* In 1970, E.F.Codd introduced Relational Data Model.

## SQL Sub Languages in every database:
### 1) Data Definition Language (DDL):
* Create
* Alter
* Drop
* Truncate
* Rename(oracle 9i)
### 2) Data Manipulation Language (DML):
* Insert 
* update 
* delete 
* merge(oracle 9i)
### 3) Data Retrieval Language(DRL) or Data Query Language(DQL):
* SELECT
### 4) Transactional Control Language (TCL):
* Commit
* Rollback
* Savepoint
### 5) Data Control Language(DCL):
* Grant
* Revoke
### Oracle 10g, 11g, 12c.(Enterprise Edition)
Username: scott
Password: tiger
Error: Account locked message displayed for first time. So, again we have to connect.
Username: \ sys as sysdba
Password: sys
SQL> alter user scott account unlock:
SQL> conn scott/tiger
Enter password: tiger
Confirm password: tiger


## Data Types
* Data types specifies type of data within a table column Oracle have following 
data types: 
1. Number(p,s)
2. Char varchar2(maxsize)
3. Date.

### Number(p,s): 
* p precision (total number of digits)
* s scale ( it is used to store fixed, floating point numbers).
* Syntax: columnname number(p,s)

* Example: SQL> create table test(sno number(7,2));
* SQL> insert into test values(123456.7)
* Error: value larger than specified precision allows for this column.
#### Note: whenever we are using number(p,s) then total number of digits before decimal places upto “p-s” number of digits.[eg:- p-s => 7-2=5]

#### Note: whenever we are using number(p,s) and also if we are passing more number of digits after decimal place then oracle server only automatically rounded that number based on specified “scale”.Number(p): It is used to store fixed numbers only. Maximum length of the precision is up to “38”.

## Char
* It is used to store fixed length “alpha numeric” data in bytes. Maximum limit is upto 2000 bytes. 
* Syntax: columnname char (size); 
* By default character data type having one byte. Character data type automatically          “Blank Padded”. 
* Blank Padded: Whenever we are passing less number of characters than the specified data type size then * * oracle server automatically allocates blank spaces after the value. Example:  
                          
#### Varchar2(maxsize): 
* It is used to store variable length alphanumeric data in bytes. Maximum limit is upto 4,000 bytes.* * * * * Whenever we are using varchar2() data type oracle server not blank padded. After the value passed into that column.  
* Syntax: columnname varchar2(maxsize); 
                       
### Date: It is used to store dates in oracle date format. 
* Syntax: columnname date; 
* In oracle by default date format is  DD- MON-YY 

## Data Definition Language(DDL): 
*   These commands are used to define structure of the table. 
*	Create 
*	Alter 
*	Drop 
*	Truncate 
*	Rename (orace 9i) 

#### 3) Create
* It is used to create database objects like tables, views, sequences, indexes. 
Creating a table: 
* Syntax: 	create 	table 	tablename(columnname1 	datatype(size), 	columnname2 datatype(size)….. ); 
* Example: SQL> create table first(sno number(10), name varchar2(10)); To view structure of the table: 


#### 3) Alter
* It is used to change structure of the existing table. 
                             
##### Add
* It is used to add number of columns into the existing table. 
* Example: SQL> alter table first add sal number(10); 

 
##### Modify
* It is used to change column datatype or column datatype size only.  
* Example: SQL> alter table first modify sno date; 
 
##### Drop
* It is used to remove columns from the existing table. 
> Method1 
* If we want to drop a single column at a time without using parenthesis”()” then we are using following syntax: 
* Alter table tablename drop column columnname; 
* Example: SQL> alter table first drop column sal; 
* SQL> desc first; 

> Method2
* If we want to drop single or multiple columns with using parenthesis then we are using following syntax. 
* Syntax: alter table tablename drop(colname1, colname2, colname3….); 
* Example: SQL> alter table first drop(sal); 
 
> Method3
* dropping all coloumns
* Error: cannot drop all columns in a table. 
* NOTE: In all database systems we cannot drop all columns in a table. 

### 3) DROP
* It is used to remove database objects from database. 
> Syntax: drop objecttype objectname; 
1.	Drop table tablename; 
2.	Drop view viewname; 
 

#### Droping a Table: 
> Syntax: drop table tablename; 
                           
#### Get it back from recycle bin. 
> Syntax: flashback table tablename to before drop; 

#### To drop permanently: 
> Syntax: drop table tablename purge;

#### RECYCLE BIN: Oracle 10g introduced recycle bin which is used to store dropped tables. Recycle bin is a read only table whenever we are installing oracle then automatically so many read only tables are created. These read only tables are also called as “ Data Dictionaries”.  
                  
#### To Drop particular table from Recycle bin: 
> Syntax: purge table tablename; 

#### To Drop all tables from Recycle bin: 
> Syntax: SQL> purge recyclebin; 
 
### 4)	Truncate
* total data permanently deleted from table. 
> Syntax: truncate table tablename; <br>
`SQL> truncate table first;` 

### 5)	Rename
It is used to rename a table and renaming a column also. 

#### Renaming a Table:  
> Syntax: rename oldtablename to new tablename; <br>
`SQL> rename first to last;` 
 
#### Renaming a Column: (oracle 9i) 
> Syntax: alter table tablename rename column oldcolumnname to newcolumnname; <br>
`SQL> alter table emp rename column empno to sno;`<br>  
Note: In all database systems by default all DDL commands are automatically committed.  
