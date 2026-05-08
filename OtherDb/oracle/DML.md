## DATA MANIPULATION LANGUAGE (DML):
These commands are used to manipulate data in a table. 

*	Insert 
*	Update 
*	Delete 
*	Merge (oracle 9i) 

### 1) Insert
It is used to insert data into a table. 
1. Method1: Insert into tablename values(value1, value2, value3…..); 
```sql 
SQL> insert into first values(1, „abc‟);
```

2. Method2: (using substitutional operator “&”) 
> Syntax: insert into tablename values(&col1, &col2, &col3……); 
```sql
SQL> insert into first values(&sno, „&name‟); 
Enter value for sno: 3 
Enter value for name: xyz 
SQL> / 
Enter value for sno: 4 
Enter value for name: sachin 
```

3. Method3: (skipping columns) 
> Syntax: insert into tablename(columnname1, columnname2,…..)values(value1,value2,…);
```sql 
SQL> insert into first(name)values(„www‟); 
```
 
### 2)	Update: It is used to change data within a table. 
* Syntax: update tablename set columnname=newvalue where columnname=oldvalue; 
```sql
SQL> update emp set sal=1000 where ename=‟SMITH‟; 
```
> Note: In all database if we want to insert data into particular cell then we must use update command. 

### 3)	Delete
* It is used to delete particular rows or all rows from a table;
1. delete all rows
>Syntax:  Delete from tablename; 

2. delete particular row
>Syntax: Delete from tablename where condition; 

#### Difference between „delete‟ and „truncate‟: 
> delete : deleted data automatically stored in a buffer. We can get it back, this deleted data using “rollback”.<br>
> truncate : total data permanently deleted
