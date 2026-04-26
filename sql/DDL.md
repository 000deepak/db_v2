## Databases 

**Create databases:**
```sql
CREATE DATABASES database_name;
```

**Drop databases:**
```sql
DROP DATABASE database_name;
```

**Use database:**
```sql
USE database_name;
```

**See the current selected database:**
```sql
SELECT database();
```

**Common Data types:**
1. Variable string:
VARCHAR(string_length)
2. Integer:
INT

## Tables
**Create my own table:**

```sql
CREATE TABLE cats (
  name VARCHAR(100),
  age INT
);
```

**Checking tables:**
```sql
SHOW TABLES;
SHOW COLUMNS FROM table_name;
DESC table_name;
```

**Dropping tables:**
```sql
DROP TABLE table_name;
```
