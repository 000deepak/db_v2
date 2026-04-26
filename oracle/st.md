### SET OPERATORS: 
* Set operators are used to retrieve data from single (or) multiple tables. 
* These operators are also called as “Vertical Joins”. 
1.	Union -> It returns unique values and also automatically sorting data. 
2.	Union all -> It returns unique + duplicate data. (no automatic sorting) 
3.	Intersect -> It returns common values 
4.	Minus -> Values are in first query those values are not in second query. 
 
```sql   
SQL> select job from emp where deptno=10 union 
select job from emp where deptno=20;
``` 
>NOTE: Whenever we are using set operators, corresponding expressions must belongs to same data type. 
```sql  
SQL> select deptno from emp union 
select dname from dept; 
Error: expression must have same data type as corresponding expression 
```
>NOTE: Always set operators returns first query column names (or) alias names as “Column headings”. 
```sql   
SQL> select dname from dept union  
select ename from emp; Output: 
DNAME 
-------- 
Accounting ADAMS ………. 
```
>NOTE: In Oracle, in corresponding expressions not belongs to same data type also then we are retrieving data from multiple query‟s using “Set Operators”. In this case we must use appropriate “Type conversion” function. 
```sql 
SQL> select deptno from emp union 
select dname from dept; 
Error: expression must have same data type as corresponding expression SOLUTION:  
SQL> select deptno “deptno”, to_char(null) “dept name” from emp union 
select to_number(null),dname from dept; Output: 
DEPTNO 	DNAME 
------------------------- 
10 	 	 
20 
30 
 	 	ACCOUNTING 
 	 	SALESMAN 
 	 	……………… 
```