## Section 6: Aggregate Functions
- aggragte meaning - total

**1. COUNT: count number of rows**
```sql
SELECT COUNT(*) FROM tablename; -- count number of row
SELECT COUNT(colname) FROM tablename; -- count number of row of a column
SELECT COUNT(DISTINCT colname) FORM tablename; -- count distinct row of a column
```

**2. GROUP BY: aggregates identical data into single rows**
- used to aggregate data based on specified columns, 
- while the HAVING clause filters the results of the aggregation.
- cannot use where for filter
- Purpose:
- GROUP BY: 
    - This clause is used to group rows that have the same values into summary rows, like finding the total revenue for each category in our example. 
    - It's often used with aggregate functions like SUM, COUNT, AVG, etc., to perform calculations on grouped data.
- HAVING: 
    - After grouping the data, sometimes you want to filter the groups based on aggregated values. That's where HAVING comes in. It allows you to specify conditions that the grouped rows must meet. In our example, we filtered out categories with a total revenue less than or equal to 10,000.

> Note : apply aggregate functions like SUM, COUNT, AVG, etc., to the columns that are not in the GROUP BY clause Other wise we will get error.    
```sql
SELECT Category, SUM(Revenue) AS TotalRevenue
FROM Sales
GROUP BY Category
HAVING SUM(Revenue) > 10000;

Sample Sales table:
Product	Category	        Revenue
A	    Electronics	        5000
B	    Electronics	        7000
C	    Clothing	        3000
D	    Clothing	        6000
E	    Furniture	        8000
F	    Furniture	        4000

sql
SELECT Category, SUM(Revenue) AS TotalRevenue
FROM Sales
GROUP BY Category
HAVING SUM(Revenue) > 10000;

Output:
Category	    TotalRevenue
Electronics	    12000
Furniture	    12000

Explanation:
- We grouped the data by the Category column.
- Calculated the total revenue for each category.
- Filtered out categories with a total revenue less than or equal to 10,000.
```

**3. MIN: return minimum column value**
```sql
SELECT MIN(colname) FROM tablename;
```

**4. MAX: return maximum column value**
```sql
SELECT MAX(colname0 FROM tablename GROUP BY colname;
```

**5. MAX/MIN with GROUP BY**
Group row first before finding minimum
```sql
SELECT colname1,
       MIN(colname2) 
FROM tablename 
GROUP BY colname2;
```

**6. SUM: sum column value**
```sql
SELECT colname1, SUM(colname2)
FROM tablename
GROUP BY colname2;
```

**7. AVG: average column value**
```sql
SELECT AVG(colname) FROM tablename;

SELECT colname1, AVG(colname2)
FROM tablename
GROUP BY colname2;
```