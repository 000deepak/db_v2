## DATA RETRIVAL LANGUAGE(DRL) (OR) DATA QUERY LANGUAGE(DQL): 
* we can retrieve data fromtable using select statement.  

1.	Select all cols and all rows. 
2.	Select all cols and particular rows. 
3.	Select particular cols and all rows. 
4.	Select particular cols and particular rows. 
 
1. Creating a new table from another table: 
```sql 
create table newtablename as select * from existingtablename; 
```
> Note: In all database systems whenever we are copying a table from another table constraints are never copied. (Primary table, Foreign key,…..); 
2. Creating a new table from existing table without copying data:
```sql 
create table newtablename as select * from existingtablename where falsecondition; 
```

### Operators Used in “Select” statement: 
1.	Arthematic operator(+,-,*,/) 
2.	Relational operator(=,<,<=,>,>=,[<> or!=]not equal). 
3.	Logical operator (AND,OR,NOT) 
4.	Special operator. 
 
## Special operators: 
1)	`In` opposite `not in` 
2)	`between` opposite `not between` 
3)	`is null` opposite is `not null` 
4)	`like` opposite not `like` 
 
### 1. In
* It is used to pick the values one by one from list of values. „In‟ operator performance is very high compared to „OR‟ operator. If we want to retrieve multiple values in a single column then we are using „IN‟ operators in place of „OR‟ operator because „IN‟ operator performance is high. 
* Syntax: select * from tablename where columnname in(list of values); 
> Columnname belongs to any data type is possible.
```sql  
Example: SQL> select * from emp where deptno in(20,30,50,70,90); 
 ```
> Note:whenever we are using multiple row sub queries then we must use “in” operator.
```sql  
Eg: select * from emp where deptno not in(10,20,null);
``` 
>Note: In all relational databases “not in” operator doesnt  work with “null” values. 

##### Null
* Null is an undefined, unavailable, unknown value. It is not same as “zero”. Any arithmetic operations performed on null values again it becomes “null”.
```sql 
Eg: null+50-> null. 
```
> To overcome this problem oracle provided “NVL()” function. 
#### NVL()
* predefined function which is used to replace or substitute user defined value in place of “null”. 
* Syntax: NVL(exp1,exp2); 
Here exp1,exp2 must belongs to same datatype. If exp1 is null then it returns exp2. Otherwise it returns exp1.
```sql  
NVL(null,30) -> 30. 
```
 
#### NVL2() 
* Syntax: NVL2(exp1,exp2,exp3). 
Here if exp1 is null, then it returns exp3. Otherwise it returns exp2. 
```sql 
SQL> select nvl2(null,10,20) from dual; 
20
``` 
 
### 2)	Between
* This operator is used to retrieve range of values. This operator is also call as Betweem….. And operator. 
* Syntax: Select * from tablename where columnname between lowvalue and highvalue. 
```sql 
select * from emp where sal between 2000 and 5000; 
```

While using “DATE”: 
SQL> select * from emp where hiredate between ‟01-jan-1981‟ and ‟01-jan-1982‟; 
 
### 3)	Is null, is not null
* These two operators used in „where” condition only. These two operators are used to test weather a column having null values or not. 
```sql 
select * from tablename where columnname is null; 
select * from tablename where columnname is not null;
``` 

### 4) Like
* It is used to search strings based on character pattern. “Like” operator performance is very high compare to searching functions. 

>In all databases along with like operator we are using 2 wild card charcters. <br>
> Two types of wild card characters 
* % -> group of characters if want to match or string 
* _ -> single character to match. 
```sql 
 select * from tablename where columnname like characterpattern; 
```

“Escape” function used in like operator: 
* Whenever wild card characters available in character data then we are trying to retrieve the data using like operator then database servers treated these wild card characters as special characters to overcome this problem ansi/iso SQL provided a special function “Escape” along with „like‟ operator. Which is used to escape special characters and also this function treated as _,% as same meaning as _,%.

* Syntax: select * from tablename where columnname like „character pattern‟ escape „escape character‟; 
>Note: Escape character must be an single character having length „1‟ within character pattern we must use escape character before wild card character. 
```sql 
SQL> insert into emp(empno, ename) values(1,‟S_ MITH‟);
``` 
 
### Concatenation Operator(|| double pipe)
* It is not a special operator rarely used in “SQL” and regularly used in “PL/SQL”. 
* If we want to display column data along with literal strings then we must use concatenation operator. 
```sql 
select „my employee names are‟|| ename from emp;
``` 
>If we want to display our own space in between the columns then also we can use concatenation operator. 
```sql  
select ename||‟                 „||sal from emp;
``` 
