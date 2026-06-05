
## Section 4: String functions
**1. SOURCE: load sql file**
```sql
SOURCE filename.sql
```

**2. CONCAT: concatenates two or more expressions together.**
```sql
SELECT 
  CONCAT(col1, ' ', col2) AS 'new col'
FROM tablename;
```

**3. CONCAT_WS: concatenates with first argument separator**
```sql
SELECT 
  CONCAT_WS('-', col1, col2, col3) 
FROM tablename;
```

**4. SUBSTRING: select substring of a string**
```sql
SELECT SUBSTRING(colname, start, end)
FROM tablename;
```

**5. REPLACE: replace part of a string (case sensitive)**
```sql
SELECT REPLACE('string1', 'str', '123');
```

**6. REVERSE: reverse a string**
```sql
SELECT REVERSE('123');
SELECT REVERSE('a string') FROM tablename;
```

**7. CHAR_LENGTH: return string length**
```sql
SELECT CHAR_LENGTH('123');
SELECT CHAR_LENGTH('string') FROM tablename;
```

**8. UPPER: return uppercase string**
```sql
SELECT UPPER('123');
SELECT UPPER('string') FROM tablename;
```

**9. LOWER: return lowercase string**
```sql
SELECT LOWER('123');
SELECT LOWER('string') FROM tablename;
```