### JOINS
* Joins are used to retrieved data from multiple tables. In all databases when we are joingin “n” tables then we must use “n-1” joining conditions. Oracle having following types of joins. 
1.	Equi joing (or) Inner join 
2.	Non equi join 
3.	Self join 
4.	Outer join 
 
These 4 joins are also called as “8i joins”,9i joins or ansi joins. 
1.	Inner join 
2.	Left outer join 
3.	Right outer join 
4.	Full outer join 
5.	Natural join 
 
In oracle, we can also retrieve data from multiple tables without using join condition in this case oracle server internally uses cross join. But cross join is implemented based on Cartesian product that‟s why this internal join returns more duplicate data. Eg: SQL> select ename, sal, dname, loc from emp, dept; 
 
### 1. Equi join (or) Inner join
* Based on equality condition we are retrieving data from multiple tables. Here joining conditional columns must belongs to same datatype. 
Generally, when tables having common columns then only we are using this “join”. 
 
Syntax: select col1, col2,…. from tablename1, tablename2 where tablename1.commoncolumnname= tablename2. Commoncolumnname; 
 
tablename. Commoncolumnname is a join condition 
Eg: SQL> select ename, sal, deptno, dname, loc from emp, dept where emp.deptno= dept.deptno; 
Error: column ambiguously defined. 
Solution: SQL> select ename, sal, dept.deptno, dname, loc from emp, dept where emp.deptno = dept.deptno; 

 
> NOTE: Generally, to avoid ambiguity in future we must specify every “column name” along with table name using „.‟ (Full stop or dot) operator. <br>

> NOTE: In all databases we can also create alias names for the table in “from” clause of the “join conditions”. These alias names are also called as “Reference names”. These reference names are used in select list, used in joining condition. <br>

```sql
Syntax:  from tablename aliasname1, tablename aliasname2. 
These alias names must be different names. 
USING ALIAS NAMES: 
SQL> select ename, sal, d.deptno,dname, loc from emp e, dept d 
Where e.deptno = d.deptno; 
 
ENAME             SAL     DEPTNO DNAME          LOC 
---------- ---------- ---------- -------------- ---------- 
CLARK            2450         10 ACCOUNTING     NEW YORK KING             5000         10 ACCOUNTING     NEW YORK 
MILLER           1300         10 ACCOUNTING     NEW YORK 
JONES            2975         20 RESEARCH       DALLAS 
FORD             3000         20 RESEARCH       DALLAS 
ADAMS            1100         20 RESEARCH       DALLAS 
SMITH             800         20 RESEARCH       DALLAS 
SCOTT            3000         20 RESEARCH       DALLAS 
WARD             1250         30 SALES          CHICAGO 
TURNER           1500         30 SALES          CHICAGO ALLEN            1600         30 SALES          CHICAGO 
JAMES             950         30 SALES          CHICAGO 
BLAKE            2850         30 SALES          CHICAGO 
MARTIN           1250         30 SALES          CHICAGO 
In the above query , here deptno(“40”) doesn‟t displayed if we are  using dept.deptno also. 
NOTE: In all databases always equi joins returns matching rows only. 
```
> Note: If we want to filter the data after joining condition then we must use “and” operator in 8i joins where as in 9i joins we are using either “and” operator or “where” clause also. 

### 2. Non Equi Join
*+ Based on other than equality condition(not equal to, >,<,>=,<=,between, in,….) we can retrieve data from multiple tables. In oracle, this join is also called as “Between….. and Join”. 
 
```sql
SQL> create table test1(deptno number(10),ename varchar2(20)); 
SQL> insert into test1 values(10,‟a‟); 
SQL> insert into test1 values(20,‟b‟); 
SQL> select * from test1; 
DEPTNO    ENAME 
--------------------- 
  10  	a 
  20  	b 
SQL> create table test2(deptno number(10),dname varchar2(20)); 
SQL>insert into test2 values(10,‟c‟); 
SQL>insert into test2 values(20,‟d‟); 
SQL>insert into test2 values(30,‟e‟); 
SQL> select * from test2; 
DEPTNO   DNAME 
---------------------- 
  10  	c 
  20  	d 
  30  	e 
SQL> select * from test1,test2 where test1.deptno>test2.deptno; 
DEPTNO    ENAME    DEPTNO    DNAME 
--------------------------------------------- 
  20  	b 	    10  	c 
  ```
> NOTE: In oracle, we can also use non-equi join when tables doesnot have common columns.
```sql 
Eg: select * from salgrade 
SQL> select ename,sal,losal,hisal from emp,salgrade where sal between losal and hisal;        OR 
Where sal>=losal and sal<=hisal; 
```

### 3.SELF JOIN
Joining a table to itself is called “self join”. Here joining conditional columns must belongs to same datatype. Before we are using self join we must create alias names for the table in “from” clause. 
Syntax: from tablename aliasname1,tablename aliasname2; 
Generally, if we want to compare two different column values in a single table then we must use self-join. But here these two columns must belong to same datatype. 

>When to use Alias names: 
>In all databases systems whenever we are refer same table more than one time foe wuery results then we must create “table alias” names. These alias names are also called as „”Reference names”. These alias names internally behaves like a tables when query execution time. These alias names must be different names. 
>Syntax: from tablename alias name1, tablename aliasname2; 

### 4. OUTER JOIN
* used to retrieve all rows from one table and matching rows from another table. 
* using “equi join” we are retrieving matching rows only.
* to retrieve non-matching rows also then we are using join operator(+). 
Within joining condition of “equi join” this join is called “ORACLE 8i Outer join”. 

> NOTE: Join operator can be used only one side at a time one joining condition.
```sql 
Eg: SQL> select ename, sal, d.deptno,dname,loc from emp e, dept d where e.deptno(+)=d.deptno; 
e.deptno- matching rows 
d.deptno- all rows 
```

### 9i JOINS or ANSI JOINS: 
1.	Inner join 
2.	Left outer join 
3.	Right outer join 
4.	Full outer join 
5.	Natural join

### 1. Inner join
* This join also returns matching rows only. Whenever tables having common columns then only we are using this join. Here also joining conditional columns must belongs to some data type. Inner join (9i) performance is very high compare to oracle 8i equi join. 
```sql
Eg: SQL> select ename, sal, d.deptno, dname, loc from emp e join dept d on e. deptno=d.deptno; 
 ```
 ```sql
Eg: SQL> create table t1(a varchar2(10), b varchar2(10),c varchar2(10)); 
SQL > insert into t1 values(„x‟,‟y‟,‟z‟); 
SQL > insert into t1 values(„p‟,‟q‟,‟r‟); 
SQL> select  * from t1; 
SQL> create table t2(a varchar2(10), b varchar2(10)); 
SQL>insert into t2 values(„x‟,‟y‟); 
SQL.> select * from t2; 
 
 
A 	 	B 	C 	 	A 	B 
--------------------------        --------------------- 
X  	 	Y 	Z 	 	X 	Y 
P 	 	q 	r 
8i equi join: 
SQL> select * from t1,t2 where t1.a=t2.a and t1.b=t2.b; 9i inner join: 
SQL> select * from t1 join t2 on t1.a=t2.a where t1.b=t2.b; 
Output: 
A 	 	B 	C 	 	A 	B 
--------------------------                --------------------- 
X  	 	Y 	Z 	 	X 	Y 
 
Date: 2/4/15 
 ```

### Using clause: 
In 9i joins we can also use “USING” clauses in place of “ON” clause. “Using” clause performance is very high compare to “ON” clause and also when we are using “USING” clause then oracle server automatically returning common columns on time only.

```sql
Syntax: select * from tablename1 join tablename2 using (common columnnames); Eg: SQL> select * from t1 join t2       using(a,b); Output:  
A  	B 	C 
----------------- 
X 	y 	z 
Note: whenever we are using “Using” clause then we are not allowed to use alias name or joining conditional columns. 
Eg: Select ename,sal,deptno,dname,loc from  emp e join dept d using (deptno); 
 ```
### 2. 	Left Outer Join: 
This join always reuturns all rows from left side table and matching rows from reight side table and also returns “NULL” values in place of non-matching rows in another table. 

```sql
Eg: select * from t1; 
A  	B 	C 
----------------- 
X 	y 	z 
P 	q 	r 
SQL> select * from t2; 
 
 
A 	B 
--------- 
X 	y 
S 	t 
SQL> select * from t1 left outer join t2 on t1.a=t2.a and t1.b=t2.b; 
A 	B 	C 	 	A 	B 
-------------------        --------------------- 
X 	Y 	Z 	 	X 	Y 
P 	q 	r 	      (null)   (null) 
 ```

### 3.	Right Outer Join: 
This Join returns all rows from right side table and matching rows from left side table and also returns null values in place of “non-matching” rows in another table. 
 
### 4.	Full Outer Join: 
This join returns all data from all the tables it is the combination of left and right outer joins. This join always returns matching and non-matching rows. And also this join returns null values in place of non-matching rows.

```sql
Eg: SQL> select * from t1 full outer join t2 on t1.a=t2.a and t1.b=t2.b; 
A 	B 	C 	 	A 	B 
------------------            ------------- 
X 	y 	z 	 	x 	y 
P 	q 	r 	       null      null 
Null   null    null 	 	s 	t 
 ```

### 5. Natural Join:
This join also returns matching rows only. When we are using “Natural Join” then we are not allowed to used to use joining condition. In this case oracle server only internally uses joining condition. But here resource tables must contain common column name. 
```sql
Syntax: select * from tablename1 natural join tablename2.
``` 
> Note: Natural Join performance is very high compared to inner join. 
> Note: This join internally uses “USING” clause. That‟s why this join also returns common columns one time only.
```sql 
Eg: SQL> select * from t1 natural join t2; Output:  
A  	B 	C 
----------------- 
X 	y 	z
```

> Note: When we are using “Natural” join also then we are not allowed to use alias name on joining conditional column because natural join internally uses “USING” clause. 
```sql
SQL> select ename,sal,deptno,dname,loc from emp e natural join dept d; 
``` 
 
### CROSS JOIN: 
Eg: select ename,sal,dname, loc from emp cross join dept; Joining more than 2-tables.(example 3 tables): 
8i JOINS 
Syntax: SQL> select col1,col2,….. from table1,table2,table3 Where table1.commoncolname=table2.commcolname  and table2. Commcolname=table3.commcolname; 9i JOIN: 
Syntax: SQL> select col1,col2,… from table1 join table2 on  table1.commcolname=table2.commcolname join table3 on table2.commcolname=table3.commcolname; 
 
## CONSTRAINTS: 
* used to prevents or stops invalid data entry into our tables.
* constraints are created on table columns. Oracle server having following types of constraints. 
1.  Not null 
2.	Unique 
3.	Primary key 
4.	Foreign key 
5.	Check 
These are called “Constraints (or) Constraint types”. 


All the above constraints are created in two ways: 
1.	Using column level 
2.	Using table level 


### 1.	Using Column level
In this methos we are defining constraints on individual columns. That is whenever we are defining the column then only immediately we are specifying constraint type. 

```sql
Syntax: create table tablename(col1 datatype(size) constraint type, col2 datatype(size) constraint type,…..); 
```
### 2.	Using Table level: 
In this method we are defining constraints on group of columns i.e., in this method first we are defining all columns and last only we are specifying constraint type along with group of columns. 
```sql
Syntax: 	create 	table 	tablename(col1 	datatype(size),col2 	datatype(size),…. 	, constrainttype (col1,col2,….));
``` 
### 1.	Not NULL
This constraint doesn‟t support table level. This constraint doesn‟t accepts null values. But it will accepts duplicate values. 
Column level: SQL> create table t1(sno number(10) not null, name varchar2(10)); 
Testing: SQL> insert into t1 values(null,‟abc‟); 
ORA-1400: cannot insert null into SNO; 
Table level: SQL> create table t1(sno number(10), name varchar2(10), not null(sno,name)); 

### 2.	UNIQUE
This constraint is defined on column level, table level. This constraint doesn‟t accepts duplicate values. But it will accepts null values. 
Note: Whenever we are creating unique constraints then oracle server internally automatically creates b-tree index on those columns. 
Column level: SQL> create table t2(sno number(10) unique, name varchar2(10)); 
Table 	level: 	SQL> 	create 	table 	t2(sno 	number(10), 	name 	varchar2(10), unique(sno,name)); 
Table created 
Eg: SQL> insert into t3(….) 
SNO  	NAME 
----------------------- 
1 	murali 
1 	 	abc 
SQL> select * from t3; 
Error: ORA-00001: Unique constraint violated. 
 
### 3.	Primary Key: 
Primary key “Uniquely identifying a record in a table”. There can be only one primary key in a table and also primary key doesn‟t accepts duplicate null values. Note: Whenever we are creating primary key then oracle server automatically create an “b- tree” indexes on those columns. 
Column level: SQL> create table t4(sno number(10) primary key, name varchar2(10)); Table created 
Table level: SQL> create table t4(sno number(10), name varchar2(10), primary key(sno,name)); 
This is also called as “Composite Primary Key” i.e., it is the combination of columns as a “single primary key”. 
 
### 4.	Foreign Key
If we want to establishes relationship between tables then we are using “Referential Integrity Constraints” (Foreign Key). One table foreign key must belongs to another table “primary key”. Here these two columns must belong to same data types. Always foreign key values based on “primary key” values only. Generally, primary key doesn‟t accepts duplicate, null, values where as foreign key accepts duplicate, null values. 

Column level (“References”): 
Syntax: create table tablename(col1 datatype(size) references master tablename(primary columnname),….); 
Eg: SQL> create table h4(sno number(10) references t4); 
Or  
SQL> create table g4(x number((10) references t4(sno)); 
 
Table Level: (Foreign key references) 
Syntax: create table tablename(col1 datatype(size),col2 datatype(size),…., foreign key(col1,col2)); 
Eg: SQL> create table h5(sno number(10), name varchar2(10), foreign key(sno,name) references t5);

Whenever we are establishing relationship between tables then oracle violates following two rules:- 
1.	Deletion in “MASTER” table 
2.	Insertion in “CHILD” table 
 
### 1. Deletion in “Master” table
When we try to delete master table record if child table records are exist, then oracle server returns an error “ORA-2292” to overcome this problem first we are deleting child table records in “child table” and then only we are deleting appropriate “master table” records within master table. Otherwise using  “on delete cascade” clause. 

#### ON DELETE CASCADE
When we are using this clause in child table then if we are deleting a “master table” record within master table then oracle server automatically deletes “master table” records in master table and also deletes corresponding records in “child table”. 

```sql
Syntax: create table tablename(col1 datatype(size) references mastertablename 
(primary key colname) on delete cascade,…..); 
Eg: SQL> create table mas(sno number(10) primary key); 
SQL> insert into mas values(……..); 
SQL> select * from mas; 
SNO 
---- 
1 
2 
3 
 
SQL> create table child(sno number(10) references mas(sno) on delete cascade); 
SQL> insert into child values(……..); 
SQL> select * from child; 
SNO 
----- 
1 
1 
2 
2 
3 
3 
 
Testing : (deletion in master table) 
SQL> delete from mas where sno=1; 
1	row deleted 
SQL> select * from mas: 
SQL> select * from child; 
SNO  	SNO 
----             ---- 
2	2 
3	2 
   	 	3 
   	 	3 
Oracle also supports another clause along with foreign key “ON DELETE SET NULL”. 
```

### ON DELETE SET NULL: 
Whenever we are using this clause the “child table” then if we deleting a master table record then oracle server automatically deletes primary key value in master table and also corresponding foreign key values are automatically set to null in child table. 
```sql
Syntax:  create table tablename(col datatype(size) reference master tablename(primary key colname) on delete set null,……); 
```

### 2. INSERTION IN CHILD TABLE
In Oracle, when we are trying to insert other than primary key values into Foreign key then oracle server returns an error “ORA-2291”. Because in all database systems always foreign key values are based on primary key values only. 
```sql
SQL> insert into child values(5); 
ORA-2291: Intergrity constraint violated-parent key not found. 
Solution: SQL> insert into mas values(5); 
SQL> select * from mas; 
SQL> insert into child values(5); 
SQL> select * from mas; 
Example based on dept(master table), emp(child table): 
1)	Deletion in Master table: 
SQL> delete from dept where deptno=10; 
ORA-2292: integrity constraint violated- child record foun. 
2)	Insertion in child table: 
SQL> insert into emp(empno,deptno) values(5,90); 
ORA-2291: Integrity constraint violated – parent key not found  
In oracle, we are not allowed to define logical condtions using “SYSDATE” within check constraint. 
COLUMN LEVEL: 
Syntax: create table tablename(col1 datatype(size) check(logical condition),col2 datatype(size),…..); 
Eg: create table t6(sal number(10) check (sal>5000)); 
SQL> insert into t6 values(3000); 
Error: check constraint(scott.syst_c005513) violated 
SQL> insert into t6 values(9000); 
SQL> select * from t6; 
SAL 
----- 
9000 
Eg: create table t7(name varchar2(20) check(name=upper(name))); 
SQL> insert into t7 values(„murali‟); 
Error: check constraint(scott.syst_c00514) violated 
SQL> insert into t7 values („MURALI‟); 
SQL> select * from t7; 
NAME 
------ 
MURALI 
Table level: 
Eg: SQL> create table t8(name varchar2(20), sal number(10), check(name=upper(name) and sal>5000)); 
Assign User defined names to Constraints (OR) User defined Constraint Names: 
In all database systems whenever we are creating constraints then database servers internally automatically generates an unique identification number for indentifying a constraint uniquely. 
In Oracle also whenever we are creating constraints then oracle server automatically generates an unique identification number in the format of “SYS_Cn”. This is called “Predefined Constraint Name”. In place of this one we can also create our own name using “Constraint Keyword”. This is called “Used defined Constraint Name”. 
Syntax: Constraint user defined name constraint_type; 
Here, constraint-> keyword 
Constraint_type-> Not null, unique, primary key, foreign key, check 
User defined name->constraint name 
Eg 1: (Predefined Constraint Name) 
SQL> create table t10(sno number(10) primary key; Testing: 
SQL> insert into t10 values(1); 
SQL> insert into t10 values(1); 
Error: unique constraint (SCOTT.SYS_C005516) violated 
Eg 2: User defined Constraint Name 
SQL> create table t11 (sno number(10) constraint p_abc primary key); Testing:  
SQL> insert into t11 values(1); 
SQL> insert into t11 values(1); 
Error: unique constraints (SCOTT.P_ABC) violated Data Dictionaries: 
Whenever we are installing oracle server then oracle server automatically creates some read only tables. These read only tables are also called as “Data Dictionaries”. 
 ```                       
 