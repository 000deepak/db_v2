
## SELECT
**1. DISTINCT:**<br>
find the distinct row of a column
```sql
SELECT DISTINCT colname FROM tablename;
SELECT DISTINCT colname1, colname2 FROM tablename;
```

**2. ORDER BY:** <br>
sort results (ascending default)
The ORDER BY keyword is used to sort the result-set by a specified column.
The ORDER BY keyword sort the records in ascending order by default.
If you want to sort the records in a descending order, you can use the DESC keyword.

```sql
SELECT colname FROM tablename ORDER BY colname; 

SELECT colname FROM tablename ORDER BY colname DESC; -- descending order

SELECT colname FROM tablename ORDER BY 1; -- sort by column 1 

SELECT colname FROM tablename ORDER BY col1, col2; -- sort by multiple  columns
```
**3. LIMIT:**<br>
limit response length
```sql
SELECT colname FROM tablename LIMIT 5; -- limit reponse to 5 rows

SELECT colname FROM tablename LIMIT 0,5; -- limit response to 5 rows starts at 0 to end at 5
```

**4. LIKE:** <br>
search for a specified pattern in a column
% : The percent sign represents zero, one, or multiple characters
_ : The underscore represents a single character

```sql
WHERE colname LIKE '%a%'; -- contain a

WHERE colname LIKE '%a'; -- ends with a

WHERE colname LIKE 'a%'; -- starts with a 

WHERE colname LIKE '_a%'; -- second letter with a 
```

**5. Wildcard:** <br>
substitute any other character(s) in a string.
```sql
WHERE colname LIKE '%\%%'; -- match a percent sign

WHERE colname LIKE '%\_%'; -- match a underscore symbol

WHERE colname LIKE '__'; -- 2 char length long

WHERE colname LIKE '[a-z]%'; -- match letter starts from a to z

WHERE colname LIKE '[abc]%'; -- match staring starts with letter a or b or c
```
